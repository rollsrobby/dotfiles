{ config, ... }:

{
  home.username = "rms";
  home.homeDirectory = "/Users/rms";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file = {
    ".config/aerospace".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/aerospace";
    ".config/nix-darwin".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix-darwin";
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    ".config/starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship/starship.toml";
    ".config/sesh".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/sesh";
    ".config/tmux".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux";
    ".config/ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ghostty";
  };

  imports = [
    ./modules/cli.nix
    ./modules/applications.nix
  ];
}
