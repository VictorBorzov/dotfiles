{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    bitwarden
    librewolf
    mullvad-vpn
    jetbrains.rider
    remmina
    slack
    telegram-desktop
    syncthing
    libreoffice
  ];


  home.file.".config/alacritty/alacritty.yml".source = /home/vb/dotfiles/config/alacritty/alacritty.yml;
}
