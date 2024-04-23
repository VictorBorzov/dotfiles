{ config, pkgs, ... }:

{
  # enable gtk
  # gtk.enable = true;

  # gtk.cursorTheme.package = pkgs.bibata-cursors;
  # gtk.cursorTheme.name = "Bibata-Modern-Ice";

  # gtk.theme.package = pkgs.adw-gtk3;
  # gtk.theme.name = "adw-gtk3";

  # gtk.iconTheme.package = pkgs.gruvboxPlus;
  # gtk.iconTheme.name = "GruvboxPlus";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 22;
  };

  # enable qt
  qt.enable = true;

  # platform theme "gtk" or "gnome"
  qt.platformTheme = "gtk";

  # name of the qt theme
  qt.style.name = "adwaita-light";

  # package to use
  qt.style.package = pkgs.adwaita-qt;

  home.packages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true "]; }))
    gnome.file-roller
    rofi-wayland
    # swaylock-effects
    # swayidle
    hyprlock
    hypridle
    hyprcursor
    # swww
    hyprpaper
    kitty
    dunst
    libnotify
    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    # hyprland-share-picker
    pavucontrol
    pipewire
    wireplumber
    hyprpicker
    # hyprshade
    brightnessctl
    alsa-utils
    grim
    slurp
    vvave
    wl-clip-persist
    wl-clipboard
    swappy
    breeze-gtk
    kitty-themes
    # todo mpv
  ];

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/swaylock".source = config.lib.file.mkOutOfStoreSymlink ./config/swaylock;
  home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/hyprland.conf;
  home.file.".config/hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/hyprlock.conf;
  home.file.".config/hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/hypridle.conf;
  home.file.".config/hypr/hyprpaper.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/hyprpaper.conf;
  home.file.".config/hypr/rose-pine-dawn.conf".source = ./config/hypr/rose-pine-dawn.conf;
  home.file.".config/hypr/ecomode.sh".source = ./config/hypr/ecomode.sh;
  home.file.".config/hypr/screenshot.sh".source = config.lib.file.mkOutOfStoreSymlink ./config/hypr/screenshot.sh;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/swappy/config".source = config.lib.file.mkOutOfStoreSymlink ./config/swappy/config;
  home.file.".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink ./config/waybar/config;
  home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink ./config/waybar/style.css;
  home.file.".config/waybar/rose-pine-moon.css".source = ./config/waybar/rose-pine-moon.css;
  home.file.".config/waybar/rose-pine-dawn.css".source = ./config/waybar/rose-pine-dawn.css;
  home.file.".config/waybar/rose-pine.css".source = ./config/waybar/rose-pine.css;
  home.file.".config/gtk-3.0/colors.css".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-3.0/colors.css;
  home.file.".config/gtk-3.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-3.0/gtk.css;
  home.file.".config/gtk-3.0/settings.ini".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-3.0/settings.ini;
  home.file.".config/gtk-4.0/colors.css".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-4.0/colors.css;
  home.file.".config/gtk-4.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-4.0/gtk.css;
  home.file.".config/gtk-4.0/settings.ini".source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-4.0/settings.ini;
}
