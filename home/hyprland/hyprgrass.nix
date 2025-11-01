{ config, pkgs, lib, inputs, ... }:

let
  mkBind = { key, command ? null, dispatcher ? null }: lib.mkMerge [
    { inherit key; }
    (lib.optionalAttrs (command != null) { inherit command; })
    (lib.optionalAttrs (dispatcher != null) { inherit dispatcher; })
  ];
in {
  wayland.windowManager.hyprland = {

    plugins = [  inputs.hyprgrass.packages.${pkgs.system}.default];

    settings = {
      plugin.touch_gestures = {
        sensitivity = 4.0;
        workspace_swipe_fingers = 3;
        emulate_touchpad_swipe = true;
        long_press_delay = 400;
        resize_on_border_long_press = true;
        edge_margin = 10;
        experimental.send_cancel = 0;

        hyprgrass-bind = map mkBind [
          { key = "swipe:3:u"; command = "fullscreen 1"; }
          { key = "swipe:3:d"; command = "fullscreen 1"; }
          { key = "swipe:4:u"; command = "fullscreen 0"; }
          { key = "swipe:4:d"; command = "fullscreen 0"; }

          { key = "pinch:?:cw"; command = "splitratio 0.1"; }
          { key = "pinch:?:ccw"; command = "splitratio -0.1"; }

          { key = "pinch:4:i"; command = "killactive"; }
          { key = "pinch:4:o"; command = "exec kitty"; }

          { key = "swipe:2:lu"; command = "workspace 1"; }
          { key = "swipe:2:ld"; command = "workspace 2"; }
          { key = "swipe:2:ru"; command = "workspace 3"; }
          { key = "swipe:2:rd"; command = "workspace 4"; }
        ];

        hyprgrass-bindm = map mkBind [
          { key = "longpress:2"; dispatcher = "movewindow"; }
        ];
      };
    };
  };
}
