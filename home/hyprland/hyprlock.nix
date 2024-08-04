{
  self,
  config,
  inputs,
  ...
}: let
  font_family = "Iosevka Nerd Font";
  w1 =
    if false
    then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.png"
    else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/autumn-forest-trees-b9-2880x1800.jpg";
  w2 =
    if false
    then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.png"
    else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.png";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
      };

      background = [
        {
          monitor = "eDP-1";
          # only png supported for now
          path = w1;
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 4; # 0 disables blurring
          blur_size = 2;
          noise = 1.17e-2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }

        {
          monitor = "HDMI-A-1";
          # only png supported for now
          path = w2;
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 4; # 0 disables blurring
          blur_size = 2;
          noise = 1.17e-2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";
          size = "1000, 200";
          outline_thickness = 1;
          dots_size = 0.5; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.1; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgb(000000)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
          hide_input = false;
          position = "0, -300";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "eDP-1";
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 250;
          inherit font_family;

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "eDP-1";
          text = "Hi, please enter the password...";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 65;
          inherit font_family;

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
