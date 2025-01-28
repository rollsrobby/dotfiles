{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util, nix-homebrew, ... }:
  let
    configuration = { pkgs, ... }: {
      services.nix-daemon.enable = true;

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        with pkgs; [ 
        aerospace
        azurite
        cargo
        colima
        docker
        git
        lazydocker
        lazygit
        # neovim
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
        ngrok
        sesh
        tailwindcss-language-server
        lua-language-server
        nil
        tmux
        typescript
        typescript-language-server
        vscode-langservers-extracted
        wezterm
        yq
        ];

      homebrew = {
        enable = true;
        casks = [
          "1password"
            "alfred"
            "bartender"
            "boop"
            "expressvpn"
            "ghostty"
            "homerow"
            "karabiner-elements"
            "logi-options+"
            "microsoft-azure-storage-explorer"
            "onedrive"
            "whatsapp"
        ];
      };

      security.pam.enableSudoTouchIdAuth = true;
	      system.defaults = {
          NSGlobalDomain = {
            AppleShowAllExtensions = true;
            InitialKeyRepeat = 15;
            KeyRepeat = 2;
            NSAutomaticSpellingCorrectionEnabled = false;
            "com.apple.mouse.tapBehavior" = 1;
            "com.apple.swipescrolldirection" = false;
          };
          controlcenter.BatteryShowPercentage = true;
          dock = {
            orientation = "right";
            persistent-apps = [];
            tilesize = 32;
            largesize = 36;
            magnification = true;
            autohide = true;
            show-recents = false;
            mru-spaces = false;
            expose-group-apps = true;
          };
          spaces.spans-displays = true;
          # Enable once machine is the only one;
          # smb.NetBIOSName = "rms-mbp";
          trackpad.Clicking = true;
          finder = {
            _FXSortFoldersFirst = true;
            FXPreferredViewStyle = "Nlsv";
            AppleShowAllExtensions = true;
            ShowPathbar = true;
            ShowStatusBar = true;
            ShowRemovableMediaOnDesktop = false;
            ShowExternalHardDrivesOnDesktop = false;
            NewWindowTarget = "Home";
          };
          WindowManager.EnableStandardClickToShowDesktop = false;
	      };

        fonts.packages = with pkgs; [
          nerd-fonts.geist-mono
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.rms.home = "/Users/rms";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#rms-mbp
    darwinConfigurations."rms-mbp" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rms = import ./home.nix;
        }
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = "rms";
          };
        }
      ];
    };
  };
}
