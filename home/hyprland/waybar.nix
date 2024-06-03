{ config, lib, pkgs, ... }:

{
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = ''
            @define-color base            #232136;
            @define-color surface         #2a273f;
            @define-color overlay         #393552;

            @define-color muted           #6e6a86;
            @define-color subtle          #908caa;
            @define-color text            #e0def4;

            @define-color love            #eb6f92;
            @define-color gold            #f6c177;
            @define-color rose            #ea9a97;
            @define-color pine            #3e8fb0;
            @define-color foam            #9ccfd8;
            @define-color iris            #c4a7e7;

            @define-color highlightLow    #2a283e;
            @define-color highlightMed    #44415a;
            @define-color highlightHigh   #56526e;

          * {
            font-family: "JetBrainsMono Nerd Font";
            font-size: 9pt;
            font-weight: bold;
            border-radius: 0px;
            transition-property: background-color;
            transition-duration: 0.5s;
            min-height: 0;
          }
          
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
          
          window#waybar {
            background-color: transparent;
          }
          
          window>box {
            margin-left: 0px;
            margin-right: 0px;
            margin-top: 0px;
            background-color: rgb(30, 30, 46);
          }
          
          #workspaces {
            padding-left: 0px;
            padding-right: 4px;
          }
          
          #workspaces button {
            color: @muted;
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 6px;
            padding-right: 6px;
          }
          
          #workspaces button.active {
            background-color: @foam;
            color: @overlay;
          }
          
          #workspaces button.urgent {
            color: @overlay;
          }
          
          #workspaces button:hover {
            background-color: @rose;
            color: @overlay;
          }
          
          tooltip {
            background: rgb(48, 45, 65);
          }
          
          tooltip label {
            color: rgb(217, 224, 238);
          }
          
          #custom-launcher {
            font-size: 20px;
            padding-left: 8px;
            padding-right: 6px;
            color: #7ebae4;
          }
          
          #custom-emacs-org-timer {
            font-family: "Iosevka Nerd Font";
            font-size: 14px;
            padding-left: 8px;
            padding-right: 6px;
            color: @subtle;
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
          #idle_inhibitor {
            padding-left: 2px;
            padding-right: 10px;
          }
          
          #custom-remmina {
            color: rgb(255, 255, 255);
          }
          
          #custom-chat {
            color: rgb(255, 255, 255);
          }
          
          /* #mode { */
          /* 	margin-left: 10px; */
          /* 	background-color: rgb(248, 189, 150); */
          /*     color: rgb(26, 24, 38); */
          /* } */
          #memory {
            color: @iris;
          }
          
          #cpu {
            color: @pine;
          }
          
          #clock {
            color: @iris;
          }
          
          #language {
            color: @iris;
          }
          
          #idle_inhibitor {
            color: rgb(221, 182, 242);
          }
          
          #custom-wall {
            color: rgb(221, 182, 242);
          }
          
          #temperature {
            color: rgb(150, 205, 251);
          }
          
          #backlight {
            color: @rose;
          }
          
          #pulseaudio {
            color: @foam;
          }
          
          #network {
            color: #ABE9B3;
          }
          
          #network.disconnected {
            color: rgb(255, 255, 255);
          }
          
          #battery {
            color: rgb(250, 227, 176);
          }
          
          #battery.charging,
          #battery.full,
          #battery.discharging {
            color: @gold;
          }
          
          #battery.critical:not(.charging) {
            color: @love;
          }
          
          #custom-powermenu {
            color: rgb(242, 143, 173);
          }
          
          #tray {
            padding-right: 8px;
            padding-left: 10px;
          }
          
          #mpd.paused {
            color: #414868;
            font-style: italic;
          }
          
          #mpd.stopped {
            background: transparent;
          }
          
          #mpd {
            color: #c0caf5;
          }
          
          #custom-cava-internal {
            font-family: "Hack Nerd Font";
          }
      '';
      settings = {
        layer = "top";
        position = "top";
        output = ["eDP-1" "HDMI-A-1"];

        modules-left = [
          "hyprland/workspaces"
          "temperature"
          "idle_inhibitor"
          "custom/remmina"
          "custom/chat"
        ];
        modules-center = [ "custom/emacs-org-timer" ];
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
        },

      },
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰻠 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰍛 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰒢 Connected!";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/type-3/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }];
    };
}
