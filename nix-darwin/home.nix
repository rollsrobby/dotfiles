{ config, pkgs, ... }:

{
  home.username = "rms";
  home.homeDirectory = "/Users/rms";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file = {
    ".config/aerospace".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/aerospace;
    ".config/nix-darwin".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nix-darwin;
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim;
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/starship/starship.toml;
    ".config/sesh".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/sesh;
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/tmux;
    ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/wezterm;
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/ghostty;
  };

  programs.neovim.extraPackages = with pkgs; [
    typescript-language-server
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v="nvim";
      "v."="nvim .";
      vim="nvim";
      vi="nvim";
      ff="fzf";
      lg="lazygit";
      e="exit";
      c="clear";
      p="pnpm";
      b="bun";
      bud="brew update";
      bug="brew upgrade";
      bo="brew outdated --verbose";
      azs="azurite -l $TMPDIR/azurite -s";
      ".."="cd ..";
      "...."="cd ../..";
      "......"="cd ../../..";
      grep="grep --color=auto";
      cat="bat";
      ll="eza --icons --git --long --all";
      ls="eza --icons --git --long";
    };

    initExtra = ''
      eval "$(starship init zsh)"
      eval "$(thefuck --alias)"
      function sesh-sessions() {
        {
          exec </dev/tty
            exec <&1
            local session
            session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
            zle reset-prompt > /dev/null 2>&1 || true
            [[ -z "$session" ]] && return
            sesh connect $session
        }
      }

      zle     -N             sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions    
      '';

      # interactiveShellInit = ''
      #   source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh'
      # '';
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zoxide = {
      enable = true;
      options = [
        "--cmd cx"
      ];
    };
  };

  # home.file."/Library/Keyboard Layouts/EurKEY.icns" = {
  #   source = pkgs.fetchurl {
  #     url = "https://github.com/lbschenkel/EurKEY-Mac/blob/a633b854679b7d8f8be56b724b712b5d2a02a038/EurKEY.icns";
  #     sha256 = "sha256-D6EslCodXnZg4CobJKtNNcDoATBUuAiYjX7x0LbTnYA=";
  #   };
  # };
  #
  # home.file."/Library/Keyboard Layouts/EurKEY.keylayout" = {
  #   source = pkgs.fetchurl {
  #     url = " https://github.com/lbschenkel/EurKEY-Mac/blob/a633b854679b7d8f8be56b724b712b5d2a02a038/EurKEY.keylayout ";
  #     sha256 = "sha256-1hmjrQTyOtqZzlzf8OeKJaHUsm2CVClRILQfFXAAvRA=";
  #   };
  # };
}
