{ inputs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      size = 18;
      name = "Iosevka Nerd Font";
    };

    settings = {
      confirm_os_window_close = 0;

      scrollback_lines = 10000;
      placement_strategy = "center";

      allow_remote_control = "yes";
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      selection_foreground = "none";
      selection_background = "none";

      # colors
      background_opacity = "0.9";
    };

    theme = if inputs.myConfig.theme.dark then "Rosé Pine Moon" else "Rosé Pine Dawn";
  };
}
