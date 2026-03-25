{ pkgs, ... }:

{
  home.packages = with pkgs; [
    azurite
    cargo
    colima
    docker
    git
    git-spice
    lazydocker
    lazygit
    lua-language-server
    neovim
    ngrok
    nil
    nix-search-tv
    procps
    sesh
    tmux
    tmuxp
    typescript
    unar
    yq
    _1password-cli
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        n = "nvim";
        "n." = "nvim .";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
        e = "exit";
        c = "clear";
        p = "pnpm";
        b = "bun";
        k = "kubectl";
        d = "docker";
        azs = "azurite -l $TMPDIR/azurite -s";
        ".." = "cd ..";
        "...." = "cd ../..";
        "......" = "cd ../../..";
        grep = "grep --color=auto";
        cat = "bat";
        ll = "eza --icons --git --long --all";
        ls = "eza --icons --git --long";
        oc = "opencode .";
        sml = "tmuxp load ~/.tmuxp/sml.yaml -a";
        tks = "tmux kill-server";
        w = "watch -n 1 -c";
        # gs = "git-spice";
      };

      initContent = ''
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
          eval "$(gs shell completion zsh)"
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
        EDITOR = "nvim";
        PAGER = "less -FirSwX";
        PATH = "/Users/rms/.opencode/bin:$PATH";
        GIT_SPICE_NO_GS_WARNING=1;
      };

    };

    bat = {
      enable = true;
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

    fd = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "nvim";
        color_labels = "enabled";
      };
    };

    gh-dash = {
      enable = true;
      settings = {
        keybindings = {
          prs = {
            key = "M";
            command = "gh pr merge --merge {{.PrNumber}} --repo {{.RepoName}}";
            name = "Merge with Create Commit";
            confirm = true;
            #     - key: M
            #       command: gh pr merge --merge --no-delete-branch {{.PrNumber}} --repo {{.RepoName}}
          };
        };
        defaults = {
          merge = {
            deleteBranch = false;
          };
        };
      };
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
      shellWrapperName = "y";
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cx"
      ];
    };
  };
}
