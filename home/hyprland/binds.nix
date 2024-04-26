let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        # "$mod, ${ws}, moveworkspacetomonitor, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in
{
  wayland.windowManager.hyprland.settings = {
 
    "$mod" = "SUPER";
    bind = [
        "$mod,Return,exec,kitty"
        "$mod,t,exec,thunar"
        
        "$mod,Tab,cyclenext"
        "$mod,Q,killactive,"
        
        "$mod SHIFT, R, exec, ${screenshotarea}"
        "$mod, F1, exec, ~/.config/hypr/ecomode.sh"
        "$mod,F11,exec, bash ~/.config/hypr/screenshot.sh"
        "$mod,r,exec,bash ~/.config/rofi/application-launcher-wayland.sh"
        "$mod,p,exec,bash ~/.config/rofi/powermenu-wayland.sh"
        "$mod,f,fullscreen"
        "$mod SHIFT,f,fakefullscreen"
        "$mod SHIFT,l,exec,hyprlock"
        "$mod SHIFT,c,exec,hyprpicker | wl-copy"
        
        # swap windows
        "$mod,left,movewindow,l"
        "$mod,down,movewindow,d"
        "$mod,up,movewindow,u"
        "$mod,right,movewindow,r"
        
        # Move focus with mainMod + arrow keys
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        
        # toggle float on active window
        "$mod, w, togglefloating"
        "$mod, y, togglesplit"
        
        "$mod ALT, ,resizeactive,"
        # "$mod,SHIFT,left,resizeactive,-40 0"
        # "$mod,SHIFT,down,resizeactive,0 40"
        # "$mod,SHIFT,up,resizeactive,0 -40"
        # "$mod,SHIFT,right,resizeactive,40 0"
        
        #move and resize with SUPER and mouse
        "$mod,mouse:272,movewindow"
        # "$mod,SHIFT,mouse:272,resizewindow"
        
        # Volume and Brightness
        "$mod, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%+"
        "$mod, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"
        "$mod, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$mod, XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "$mod, XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mod, XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ]
    ++ workspaces;
  };
}
