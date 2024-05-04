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

gtk = {
  enable = true;
  theme = {
    package = if inputs.myConfig.theme.dark then pkgs.palenight-theme else pkgs.gruvterial-theme;
    name = if inputs.myConfig.theme.dark then "palenight" else "gruvterial";
  };
  iconTheme = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };
  font = {
    name = "Sans";
    size = 11;
  };
};

  # enable qt
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = if inputs.myConfig.theme.dark then "adwaita-dark" else "adwaita-light";
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
  home.file.".config/hypr/ecomode.sh".source = ./config/hypr/ecomode.sh;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink ./config/waybar/config;
  home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink ./config/waybar/style.css;
  home.file.".config/waybar/rose-pine-moon.css".source = ./config/waybar/rose-pine-moon.css;
  home.file.".config/waybar/rose-pine.css".source = ./config/waybar/rose-pine.css;
}
