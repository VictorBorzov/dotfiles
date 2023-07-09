{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
    zoom-us
    bitwarden
    librewolf
    mullvad-vpn
    remmina
    slack
    telegram-desktop
    syncthing
    libreoffice
  ];

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/alacritty/alacritty.yml".source = ./config/alacritty/alacritty.yml;
  home.file.".config/wezterm/wezterm.lua".source = ./config/wezterm/wezterm.lua;
}
