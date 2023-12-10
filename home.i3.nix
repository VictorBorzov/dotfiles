{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xkblayout-state
    rofi # application launcher
    i3status-rust # gives you the default i3 status bar
    i3lock #default i3 screen locker
    i3blocks #if you are planning on using i3blocks over i3status
    brightnessctl
    pavucontrol
    pipewire # do I need it?
    xclip
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 48;
  };

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink ./config/i3/config;
  home.file.".config/i3status-rust/config.toml".source = config.lib.file.mkOutOfStoreSymlink ./config/i3status-rust/config.toml;
}
