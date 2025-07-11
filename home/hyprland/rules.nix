{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # "opacity 0.9 override 0.9 override,class:(foot),title:(.*)"
      # "opacity 0.95 override 0.95 override,class:(emacs),title:(.*),fullscreen:0"
      # "opacity 0.95 override 0.95 override,class:(emacs),title:(.*),fullscreen:true"
      "float,class:(pavucontrol)"
      "float,class:(blueman-manager)"
      "float,class:(nm-connection-editor)"

      # jetbrains + xwayland popups fix
			"focusonactivate,class:^(jetbrains-.*)$,floating:1"
			#! Fix splash screen showing in weird places and prevent annoying focus takeovers
 			"center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
 			"nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
 			"noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
      # Center popups/find windows"
			"center,class:^(jetbrains-.*)$,title:^( )$,floating:1"
			"stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1"
			"noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1"
			# Disable window flicker when autocomplete or tooltips appear"
			"nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1"
    ];
  };
}
