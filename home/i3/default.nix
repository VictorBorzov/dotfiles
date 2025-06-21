{ config, pkgs, lib, ... }:

let
  screenshotArea = "maim -s | xclip -selection clipboard -t image/png";
  swappyClipboard = "xclip -selection clipboard -t image/png -o | swappy -f -";
  send-ed-write = ''
    ${pkgs.wtype}/bin/wtype "w /tmp/ed-preview.txt"
    ${pkgs.wtype}/bin/wtype $'\n'
  '';

  i3statusConf = pkgs.writeText "i3status.conf" ''
    general {
      colors = true;
      interval = 5;
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
      format_up = "W: (%quality) Leaked IP: %ip"
      format_down = "W: down"
    }

    ethernet _first_ {
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
in
{
  xresources.properties = {
    "Xft.dpi" = "96";
    "Xft.antialias" = "1";
    "Xft.hinting" = "1";
    "Xft.rgba" = "rgb";
    "Xft.hintstyle" = "hintslight";
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";
      focus.followMouse = false;
      gaps.inner = 5;
      gaps.outer = 10;

      fonts = {
        names = [ "Iosevka" ];
        size = 10.0;
      };

      bars = [{
        statusCommand = "${pkgs.i3status}/bin/i3status -c ${i3statusConf}";
        trayOutput = "primary";
        mode = "hide";
      }];

      keybindings = lib.mkOptionDefault {
        "Mod4+Tab" = "workspace back_and_forth";
        "Mod4+Shift+P" = "exec wlogout";
        "Mod4+Shift+R" = "exec ${screenshotArea}";
        "Mod4+Shift+T" = "exec ${swappyClipboard}";
        "Mod4+Shift+O" = "exec ${pkgs.hyprpicker}/bin/hyprpicker -a";
        # "Mod4+Shift+W" = "exec ${send-ed-write}";

        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 1%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 1%+";
      };
    };
  };

  programs = {
    i3lock.enable = true;
    wlogout.enable = true;
  };

  services = {
    blueman-applet.enable = true;
    dunst.enable = true;
  };

  gtk.enable = true;
  qt.enable = true;

  home.sessionVariables = {
    GDK_SCALE = "1";
    QT_QPA_PLATFORM = "xcb";
    XDG_SESSION_TYPE = "x11";
  };

  home.packages = with pkgs; [
    file-roller
    rofi
    dunst
    libnotify
    networkmanagerapplet
    pavucontrol
    pipewire
    wireplumber
    brightnessctl
    alsa-utils
    vvave
    xclip
    maim
    swappy
    kdePackages.breeze-gtk
    hyprpicker
    wtype
  ];
}
