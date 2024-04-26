{ config, ... }:
let
  variant = config.theme.name;
  pointer = config.home.pointerCursor;
in
{
  wayland.windowManager.hyprland.settings = {
 
    monitor = [
      "eDP-1,2880x1800@90,0x0,2"
      "HDMI-A-1,1920x1080,1440x0,1.2"
    ];
    
   "$mod" = "SUPER";
    env = [
      "WLR_NO_HARDWARE_CURSORS,1"
      "WLR_RENDERER_ALLOW_SOFTWARE,1"
      "GDK_DPI_SCALE,0.5"
      "QT_SCALE_FACTOR,1"
      "GDK_SCALE,2"
      "XCURSOR_SIZE,32"
      "GDK_BACKEND,wayland,x11"
      "QT_QPA_PLATFORM,wayland;xcb"
      "SDL_VIDEODRIVER,wayland"
      "CLUTTER_BACKEND,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_AUTO_SCREEN_SCALE_FACTOR,2"
      "GTK_THEME,Breeze"
      "QT_STYLE_OVERRIDE,Breeze"
      "XCURSOR_THEME,XCursor-Pro-Light"
    
  # use primarly amd gpu, if it's not available then use nvidia card
      "WLR_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
      
      "HYPRCURSOR_THEME,bibata"
      "HYPRCURSOR_SIZE,24"
        
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    exec-once = [
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"
      "hyprpaper"
      "dunst"
      
      "hypridle"
      "waybar"
      "blueman-applet"
      "nm-applet"
      "hyprctl setcursor XCursor-Pro-Light 24"
      "hyprlock"
    ];

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input = {
      kb_layout = "us,ru";
      kb_options = "grp:win_space_toggle";
      follow_mouse = 1;
      touchpad.natural_scroll = 1;
      sensitivity = 0.3; # -1.0 - 1.0, 0 means no modification.
    };
        
    device = {
      name = "wacom-intuos-s-pen";
      output= "HDMI-A-1";
    };
    
    general = {
      gaps_out = 20;
      border_size = 3;
      "col.active_border" = "rgba(ffffffee)";#$muted; # rgba(ffffffee)
      "col.inactive_border" = "rgba(ffffffee)";#$overlay; # rgba(ffffffee)     
      layout = "dwindle";
    };
    
    decoration = {
      rounding = 10; # 6 or 3
      active_opacity = 1.0; # 0.95
      inactive_opacity = 0.9; # 0.95
      fullscreen_opacity = 1.0;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        new_optimizations = 1;
        blurls = "waybar";
      };
      
      drop_shadow = true;
      shadow_range = 30;
      shadow_render_power = 3;
      "col.shadow" = "0x66000000";
    };
        
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
        
    master = {
      new_is_master = true;
      orientation = "left";
    };
        
    gestures = {
      workspace_swipe = true;
      workspace_swipe_invert = true;
      workspace_swipe_min_speed_to_force = 10;
      workspace_swipe_cancel_ratio = 0.85;
    };
        
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = false;
    };

    xwayland = {
      use_nearest_neighbor = true;
      force_zero_scaling = true;
    };
  };
}
