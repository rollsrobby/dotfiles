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
        bat
        cargo
        colima
        cmake
        curl
        docker
        eza
        fzf
        gettext
        # ghostty
        git
        lazygit
        libunistring
        ninja
        neovim
        ripgrep
        sesh
        starship
        tailwindcss-language-server
        lua-language-server
        nil
        thefuck
        tmux
        typescript
        typescript-language-server
        vscode-langservers-extracted
        wezterm
        yazi
        yq
        zsh-vi-mode
        ];

      homebrew = {
        enable = true;
        casks = [
          "1password"
            "alfred"
            "bartender"
            "boop"
            "ghostty"
            "karabiner-elements"
            "logi-options+"
            "onedrive"
            "whatsapp"
        ];
      };

      security.pam.enableSudoTouchIdAuth = true;
	      system.defaults = {
          NSGlobalDomain = {
            InitialKeyRepeat = 15;
            KeyRepeat = 2;
            AppleShowAllExtensions = true;
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

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";


      # programs.zsh.interactiveShellInit = ''
      #   source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh'
      # '';

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
