{ pkgs, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
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
      };
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.blueman.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # Scale java sdk apps like JetBrains IDE
    # JAVA_TOOL_OPTIONS = "-Dsun.java2d.uiScale=2.0";
  };

  # from sway nixos https://nixos.wiki/wiki/Sway
  security.polkit.enable = true;

  # for swaylock to work
  # security.pam.services.swaylock = {};
  # security.pam.services.swaylock.text = ''
    # # PAM configuration file for the swaylock screen locker. By default, it includes
    # # the 'login' configuration file (see /etc/pam.d/login)
    # auth include login
  # '';
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg = {
    portal = {
      enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
#      wlr = {
#        enable = true;
#      };
    };
  };
}
