{ config, pkgs, ... }:

let
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";

  gestureConfig = ''
    gesture swipe up    4 hyprctl dispatch fullscreen 0
    gesture swipe up    3 hyprctl dispatch exec 'pkill -USR1 waybar'
    gesture swipe down   3 hyprctl dispatch togglespecialworkspace
		gesture swipe left 4 hyprctl dispatch splitratio -0.1
		gesture swipe right 4 hyprctl dispatch splitratio 0.1
    gesture pinch in    4 hyprctl dispatch killactive
    gesture swipe left_up 2 hyprctl dispatch workspace 1
    gesture swipe left_down 2 hyprctl dispatch workspace 2
    gesture swipe right_up 2 hyprctl dispatch workspace 3
    gesture swipe right_down 2 hyprctl dispatch workspace 4
  '';
   wrappedLibinputGestures = pkgs.writeShellScript "libinput-gestures-wrapper" ''
    export PATH=${pkgs.hyprland}/bin:${pkgs.libinput-gestures}/bin:${pkgs.xdotool}/bin:$PATH
    exec ${pkgs.libinput-gestures}/bin/libinput-gestures
  '';
in {
  home.packages = with pkgs; [
    libinput-gestures
    xdotool # Optional for more advanced mappings
  ];

  xdg.configFile."libinput-gestures.conf".text = gestureConfig;

  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "Libinput Gestures Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = wrappedLibinputGestures;
      Restart = "on-failure";
      Environment = "PATH=${pkgs.hyprland}/bin:${pkgs.libinput-gestures}/bin:${pkgs.xdotool}/bin:$PATH";
    };
    Install = {
      WantedBy = [ "default.target" "graphical-session.target" ];
    };
  };
}
