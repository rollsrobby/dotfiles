{
  config,
  pkgs,
  ...
}:

{
  homebrew = {
    enable = true;
    taps = [
      "azure/functions"
    ];
    brews = [
      "azure-functions-core-tools@4"
    ];
    casks = [
      "1password"
      "alfred"
      "autodesk-fusion"
      "bambu-studio"
      "bartender"
      "boop"
      "expressvpn"
      "ghostty"
      "homerow"
      "karabiner-elements"
      "kindavim"
      "logi-options+"
      "lm-studio"
      "leader-key"
      "microsoft-azure-storage-explorer"
      "microsoft-outlook"
      "onedrive"
      "powershell"
      "whatsapp"
      "another-redis-desktop-manager"
      "raspberry-pi-imager"
      "zen"
    ];
  };
}
