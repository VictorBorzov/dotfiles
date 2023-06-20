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
          defaultSession = "none+i3";
      };

      # Enable touchpad support (enabled default in most desktopManager).
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

      windowManager.i3 = {
        enable = true;

        extraPackages = with pkgs; [
          xkblayout-state
          rofi # application launcher
          i3status-rust # gives you the default i3 status bar
          i3lock #default i3 screen locker
          i3blocks #if you are planning on using i3blocks over i3status
       ];
      };
    };

    logind = {
      # Specifies what to be done when the laptop lid is closed.
      lidSwitch = "hibernate";
      extraConfig = ''
        HandlePowerKey=hibernate
      '';
    };
  };

}

