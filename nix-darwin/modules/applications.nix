{ pkgs, ... }:

{
  home.packages = with pkgs; [
      aerospace
      iina
      vscode
  ];
}
