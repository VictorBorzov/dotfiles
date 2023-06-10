{ pkgs, ... }:

{
  services = {

    xserver = {
        # Enable the X11 windowing system.
        enable = true;

        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        # Configure keymap in X11
        layout = "us";
        xkbVariant = "";

        # Enable touchpad support (enabled default in most desktopManager).
        #services.xserver.libinput.enable = true;
      };

    
    # systray icons
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
  ];

}
