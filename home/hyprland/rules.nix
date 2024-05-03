{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity 0.9 override 0.9 override,class:(wezterm),title:(.*)"
      "opacity 0.95 override 0.95 override,class:(emacs),title:(.*),fullscreen:0"
      "opacity 0.95 override 0.95 override,class:(emacs),title:(.*),fullscreen:true"
      "float,class:(pavucontrol)"
      "float,class:(blueman-manager)"
      "float,class:(nm-connection-editor)"
    ];
  };
}
