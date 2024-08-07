{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        output = ["eDP-1" "HDMI-A-1"];

        modules-left = [
          "hyprland/workspaces"
          "temperature"
          "idle_inhibitor"
          "custom/remmina"
          "custom/chat"
          "custom/weather"
        ];
        modules-center = ["custom/emacs-org-timer"];
        modules-right = [
          "tray"
          "hyprland/language"
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "battery"
          "clock"
        ];

        "custom/emacs-org-timer" = {
          exec = pkgs.writeShellScript "get-org-clock-timer" ''
            timer_remaining=$(emacsclient -e "(my-org-timer-remaining-time)" | sed 's/^"\(.*\)"$/\1/' | sed 's/\\//g')

            task_name=$(emacsclient -e '(if (org-clocking-p)
                             (let* ((task-name (if org-clock-current-task (substring-no-properties org-clock-current-task) "No active task")))
                               (format "%s" task-name))
                           "No active task")' | sed 's/^"\(.*\)"$/\1/' | sed 's/\\//g')

            if [ "$task_name" = "No active task" ]; then
              echo "No active task"
            elif [ "$timer_remaining" = "No timer set" ]; then
              echo "$task_name"
            else
              echo "''${task_name} [''${timer_remaining}]"
            fi
          '';
          interval = 5;
          format = "{}";
          tooltip = "Current Org Clock Task";
        };

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          tooltip = false;
        };

        "backlight" = {
          "device" = "intel_backlight";
          "interval" = 2;
          "format" = "{icon} {percent}%";
          "format-icons" = [
            "󰃞"
            "󰃟"
            "󰃝"
            "󰃠"
          ];
        };

        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}% {format_source}";
          "format-muted" = "󰖁 Muted {format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
          "tooltip" = false;
        };

        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };

        "clock" = {
          "interval" = 1;
          # "format" = "{ =%I =%M %p  %A %b %d}";
          "format" = "{:%H:%M}";
          "tooltip" = true;
          # "tooltip-format" = "{ :%A; %d %B %Y}\n<tt>{calendar}</tt>";
          "tooltip-format" = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "on-click" = "alacritty -e btm";
          "states" = {
            "warning" = 85;
          };
        };

        "cpu" = {
          "interval" = 1;
          "on-click" = "alacritty -e btm";
          "format" = "󰻠 {usage}%";
        };

        "network" = {
          "interface" = "wlp2s0";
          "format" = "{ifname}";
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "format-disconnected" = ""; # An empty format will hide the module.
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
        };

        "temperature" = {
          "critical-threshold" = 95;
          "tooltip" = false;
          "format" = "☕ {temperatureC}°C";
        };

        "custom/remmina" = {
          "format" = "󰢹";
          "on-click" = "sh -c 'env GDK_BACKEND=x11 GDK_SCALE=1 GDK_DPI_SCALE=1 CLUTTER_SCALE=1 XCURSOR_SIZE=6 remmina
' & disown";
          "tooltip" = true;
        };
        "custom/chat" = {
          "format" = "󰭹";
          "on-click" = "brave --app=https =//chat.openai.com";
          "tooltip" = true;
        };
        "custom/weather" = {
          "format" = "🌦";
          "on-click" = "alacritty --hold -e wthrr belgrade -f d";
          "tooltip" = true;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "sh -c '(sleep 0.2s; sh ~/.config/rofi/powermenu-wayland.sh)' & disown";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 16;
          "spacing" = 5;
        };
        "hyprland/language" = {
          "format" = "{short}";
          "on-click" = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
        };
      };
    };
    style = ''
      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
        }
      }

      .warning,
      .critical,
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }


      #mode,
      #clock,
      #memory,
      #temperature,
      #cpu,
      #temperature,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #language,
      #custom-powermenu,
      #custom-remmina,
      #custom-chat,
      #custom-weather,
      #idle_inhibitor {
        padding-left: 2px;
        padding-right: 10px;
      }
      #tray {
        padding-right: 8px;
        padding-left: 10px;
      }

    '';
  };
}
