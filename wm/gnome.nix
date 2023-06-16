{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # systray icons
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
  ];

}
