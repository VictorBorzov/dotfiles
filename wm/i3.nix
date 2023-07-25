{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

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

