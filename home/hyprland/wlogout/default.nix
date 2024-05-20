{ config, pkgs, ... }: {

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "${pkgs.hyprlock}/bin/hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "pkill -9 Hyprland && sleep 2";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    style = ''
      * {
        background: none;
      }

      window {
      	background-color: rgba(0, 0, 0, .8);
      }

      button {
        background: rgba(0, 0, 0, .05);
        border-radius: 8px;
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        margin: 1rem;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        font-family: "JetBrains Mono Nerd Font";
        font-size: 25;
      }

      button:focus, button:active, button:hover {
        background-color: rgba(255, 255, 255, 0.2);
        outline-style: none;
      }

             /* 
                ----------------------------------------------------- 
                Buttons
                ----------------------------------------------------- 
              */

      #lock,#logout,#suspend,#hibernate,#shutdown,#reboot {
        margin: 10px;
      }

      #lock {
              background-image: image(url("icons/lock.png"));
      }

      #logout {
              background-image: image(url("icons/logout.png"));
      }

      #suspend {
              background-image: image(url("icons/suspend.png"));
      }

      #hibernate {
              background-image: image(url("icons/hibernate.png"));
      }

      #shutdown {
              background-image: image(url("icons/shutdown.png"));
      }

      #reboot {
              background-image: image(url("icons/reboot.png"));
      }
    '';
  };

  xdg.configFile."wlogout/icons" = {
    recursive = false;
    source = ./icons;
  };

}
