{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "2";
    QT_SCALE_FACTOR = "1";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  programs.nm-applet.enable = true;

  services = {

    xserver = {
      enable = true;

      # Scale x2 for Highdpi displays
      dpi = 192;

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        # "none+i3" to turn off xfce
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
      };

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

    blueman.enable = true;
      # Enable touchpad support (enabled default in most desktopManager).
    logind = {
      # Specifies what to be done when the laptop lid is closed.
      lidSwitch = "hibernate";
      extraConfig = ''
        HandlePowerKey=hibernate
      '';
    };
  };
}

