{
  self,
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  toggleCursor = pkgs.writeShellScript "toggle-cursor" ''
    STATE="$XDG_RUNTIME_DIR/sway-cursor-hidden"

    if [ -e "$STATE" ]; then
      ${pkgs.sway}/bin/swaymsg 'seat * hide_cursor 0'
      rm "$STATE"
    else
      ${pkgs.sway}/bin/swaymsg 'seat * hide_cursor 1'
      touch "$STATE"
    fi
  '';
  screenshotarea = "grim -g \"$(slurp)\" - | wl-copy"; # requires grim and slurp
  swappyClipboard = "wl-paste | swappy -f -";
  send-ed-write = ''
                ${pkgs.wtype} "w /tmp/ed-preview.txt"
                ${pkgs.wtype} $'\n'
                '';

in {

  imports = [ ./wlogout ];

  wayland.windowManager.sway = {
    enable = true;
    # bluetooth applet shows red face doesn't work otherwise
    package = null;

    extraSessionCommands = ''
                           # "blueman-applet"
                           # "nm-applet --indicator"
                           mullvad connect
                         '';

    # checkConfig = true;
    config = {
      window = {
        titlebar = false;
        hideEdgeBorders = "both";
      };

      focus = {
        followMouse = "no";
      };


      output = {
        eDP-1 = {
          pos = "0 0";
          res = "2880x1800@90.00Hz";
          scale = "2";
        };
        HDMI-A-1 = {
          pos = "0 900";
          res = "1920x1080@60.00Hz";
          scale = "1.2";
        };
      };

      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";
      modifier = "Mod4";
      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:shifts_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          accel_profile = "adaptive";
          drag = "enabled";
          dwt = "enabled";
          tap = "enabled";
        };
      };
      keybindings = 
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+Shift+P" = "exec wlogout";
          "${modifier}+Shift+a" = "focus child";
          "${modifier}+Shift+R" = "exec ${screenshotarea}";
          "${modifier}+Shift+T" = "exec ${swappyClipboard}";
          "${modifier}+Shift+O" = "exec ${pkgs.hyprpicker}/bin/hyprpicker -a";
#          "${modifier}+Shift+W" = "exec ${send-ed-write}";
      	  "${modifier}+Shift+c" = "exec ${toggleCursor}";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessDown" = "exec brightnessctl set 1%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 1%+";
        };

      bars = [
        {
          trayOutput = "*";
          mode = "hide";
          statusCommand = "${pkgs.i3status}/bin/i3status"; 
          fonts = {
            names = [ "Iosevka" ];
            size = 10.0;
          };

        }
      ];
    };

  };

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock;
    };
    wlogout = {
      enable = true;
    };
  };

  


  gtk = {
    enable = true;
  };

  # enable qt
  qt = {
    enable = true;
  };

  services = {
    blueman-applet.enable = true;
    swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
        { event = "lock"; command = "lock"; }
      ];
      timeouts = [
        { timeout = 1200; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
        { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
      ];
    };
    gammastep = {
      enable = true;
      temperature = {
        day = 4500;
        night = 4000;
      };
      dawnTime = "6:00-7:45";
      duskTime = "5:00-6:45";
    };
  };
  home.packages = with pkgs; [
    file-roller
    rofi
    dunst
    libnotify
    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    pavucontrol
    pipewire
    wireplumber
    brightnessctl
    alsa-utils
    wl-clip-persist
    wl-clipboard
    wl-screenrec
    wlr-randr
    # self.packages.${pkgs.system}.wl-ocr
    # self.packages.${pkgs.system}.slurp
    swappy
    grim
    slurp
    kdePackages.breeze-gtk
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_DPI_SCALE = 0.5;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
