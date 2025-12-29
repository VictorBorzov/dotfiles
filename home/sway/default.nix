{
  self,
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  screenshotarea = "grim -g \"$(slurp)\" - | wl-copy"; # requires grim and slurp
  swappyClipboard = "wl-paste | swappy -f -";
  send-ed-write = ''
                ${pkgs.wtype} "w /tmp/ed-preview.txt"
                ${pkgs.wtype} $'\n'
                '';

  i3statusConf = pkgs.writeText "i3statusConf" ''
general {
        colors = true
        interval = 5
}

order += "cpu_temperature 0"
order += "disk /"
order += "wireless _first_"
order += "ethernet _first_"
order += "battery all"
order += "load"
order += "tztime local"

cpu_temperature 0 {
        format = "Tea: %degrees °C"
}

wireless _first_ {
        # format_up = "W: (%quality at %essid) %ip"
        format_up = "W: (%quality) Leaked IP: %ip"
        format_down = "W: down"
}

ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        # format_up = "E: %ip (%speed)"
        format_up = "E: Leaked IP: %ip (%speed)"
        format_down = "E: down"
}

battery all {
        format = "Fairy Dust: %percentage %status %remaining"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "Hot Loads: %1min"
}

disk "/" {
        format = "Porn Folder: %avail (too smol PepeHands)"
}

ipv6 {
        format_up = "Useless Protocol: %ipv6"
        format_down = "Useless Protocol: Down"
}
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
          "${modifier}+Shift+R" = "exec ${screenshotarea}";
          "${modifier}+Shift+T" = "exec ${swappyClipboard}";
          "${modifier}+Shift+O" = "exec ${pkgs.hyprpicker}/bin/hyprpicker -a";
#          "${modifier}+Shift+W" = "exec ${send-ed-write}";
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
          statusCommand = "${pkgs.i3status}/bin/i3status -c ${i3statusConf}"; 
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

  services.blueman-applet.enable = true;
  services.swayidle = {
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
