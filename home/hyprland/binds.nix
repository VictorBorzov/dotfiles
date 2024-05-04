{ config, inputs, ... }:
let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copy area; hyprctl keyword animation 'fadeOut,1,4,default'";

  swappyClipboard = "wl-paste | swappy -f -";

  updateHyprpaper = "hyprctl hyprpaper wallpaper \"eDP-1,${
    if inputs.myConfig.theme.dark
    then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg"
    else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/roses-2880x1800.jpg"}\" && hyprctl hyprpaper wallpaper \"HDMI-A-1,${
    if inputs.myConfig.theme.dark
    then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg"
    else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.jpg"}\"";
  
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
    # mouse movements
    bindm = [
      "$mod,mouse:272,movewindow"
      "$mod SHIFT,mouse:272,resizewindow"
    ];

    bindle = [
      # Volume and Brightness
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ];

    bind = [
        "$mod,Return,exec,wezterm"
        "$mod,t,exec,thunar"       
        "$mod,Tab,cyclenext"
        "$mod,Q,killactive,"
        "$mod SHIFT, R, exec, ${screenshotarea}"
        "$mod SHIFT, E, exec, ${swappyClipboard}"
        "$mod SHIFT, P, exec, ${updateHyprpaper}"
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
        
        # "$mod ALT, ,resizeactive,"
        # "$mod,SHIFT,left,resizeactive,-40 0"
        # "$mod,SHIFT,down,resizeactive,0 40"
        # "$mod,SHIFT,up,resizeactive,0 -40"
        # "$mod,SHIFT,right,resizeactive,40 0"
    ]
    ++ workspaces;
  };
}
