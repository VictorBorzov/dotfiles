{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true "]; }))
    rofi-wayland
    swaylock-effects
    swayidle
    swaybg
    kitty
    dunst
    libnotify
    networkmanagerapplet
    dolphin
    qt5.qtwayland
    qt6.qtwayland
    hyprland-share-picker
    pavucontrol
    pipewire
    hyprpicker
    brightnessctl
    alsa-utils
    grim
    slurp
    vvave
    wl-clip-persist
    wl-clipboard
    killall
    # todo mpv
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 22;
  };

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/swaylock".source = ./config/swaylock;
  home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/hyprland.conf;
  home.file.".config/hypr/rose-pine-dawn.conf".source = ./config/hypr/rose-pine-dawn.conf;
  home.file.".config/hypr/ecomode.sh".source = ./config/hypr/ecomode.sh;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/waybar/config".source = ./config/waybar/config;
  home.file.".config/waybar/style.css".source = ./config/waybar/style.css;
}