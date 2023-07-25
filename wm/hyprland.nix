{ pkgs, ... }:

{
  services.xserver = {
      # Enable the X11 windowing system.
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.gdm = {
          enable = true;
          wayland = true;
      };
      # desktopManager.plasma5.enable = true;

      libinput = {
        enable = true;

        touchpad = {
          # Global natural scrolling
          naturalScrolling = true;

          # Tap to press
          tapping = true;

          # Sensitivity
          accelSpeed = "0.8";
        };
      };

  };

  hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
  };

  # hyprland
  programs.hyprland = {
      enable = true;
      xwayland = {
          enable = true;
          hidpi = true;
      };
      nvidiaPatches = true;
  };

  services.blueman.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # from sway nixos https://nixos.wiki/wiki/Sway
  security.polkit.enable = true;

  # for swaylock to work
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

}
