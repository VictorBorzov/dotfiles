{ inputs, config, pkgs, ... }:
{

  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      variables = [ "--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 22;
  };

  # gtk = {
  #   enable = true;
  # };

  # enable qt
  qt = {
    enable = true;
    # platform theme "gtk" or "gnome"
    platformTheme.name = "gtk";
    # name of the qt theme
    style.name = "adwaita-light";
    # package to use
    style.package = pkgs.adwaita-qt;
  };
  
  home.packages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true "]; }))
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    gnome.file-roller
    rofi-wayland
    hyprcursor
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
    wl-screenrec
    wlr-randr
    # self.packages.${pkgs.system}.wl-ocr
    swappy
    breeze-gtk
    kitty-themes
  ];

    # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/rofi".source = ./config/rofi;

  home.file.".config/hypr/rose-pine-dawn.conf".source = ./config/hypr/rose-pine-dawn.conf;
  home.file.".config/hypr/rose-pine-moon.conf".source = ./config/hypr/rose-pine-moon.conf;
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
