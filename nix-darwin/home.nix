{ config, pkgs, ... }:

{
  home.username = "rms";
  home.homeDirectory = "/Users/rms";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file = {
    ".config/aerospace".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/aerospace";
    ".config/nix-darwin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix-darwin";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship/starship.toml";
    ".config/sesh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/sesh";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux";
  #   ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/wezterm;
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ghostty";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        n="nvim";
        "n."="nvim .";
        e="exit";
        c="clear";
        p="pnpm";
        b="bun";
        k="kubectl";
        d="docker";
        azs="azurite -l $TMPDIR/azurite -s";
        ".."="cd ..";
        "...."="cd ../..";
        "......"="cd ../../..";
        grep="grep --color=auto";
        cat="bat";
        ll="eza --icons --git --long --all";
        ls="eza --icons --git --long";
      };

      initContent = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
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

      sessionVariables = {
        EDITOR="nvim";
      };

    };

    bat = {
      enable= true;
    };

    btop = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    gh = {
      enable = true;
    };

    gh-dash = {
      enable = true;
    };

    jq = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    # thefuck = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cx"
      ];
    };
  };
}
