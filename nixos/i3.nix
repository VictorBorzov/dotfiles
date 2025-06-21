{ pkgs, inputs, ... }:

{
  # Replace swaylock PAM config with i3lock
  security.pam.services.i3lock = {};

  # i3 window manager instead of sway
  services.xserver = {
    enable = true;

    displayManager.startx.enable = true; # Or use another DM like GDM/SDDM
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps; # or pkgs.i3
    };

    # Input config (optional)
    layout = "us,ru";
    xkbOptions = "grp:shifts_toggle";

    # Enable hardware acceleration
    videoDrivers = [ "nvidia" ]; # or "modesetting", "intel", etc.
  };

  # File manager and plugins
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Hardware acceleration
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    nvidia.modesetting.enable = true;
  };

  # Fonts and rendering settings
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      autohint = false;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  # Services for mounting, thumbnails, etc.
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Backlight control
  programs.light.enable = true;

  # System tray utilities
  programs.nm-applet.enable = true;
  services.blueman.enable = true;

  # X11-compatible environment variables
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };

  # Required for network, brightness, mounting, etc.
  security.polkit.enable = true;
}
