{ self, config, inputs, ... }:
let
  font_family = "Iosevka Nerd Font";
  w1 = if self.theme.dark
       then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.png"
       else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/roses-2880x1800.png";
  w2 = if self.theme.dark
       then "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.png"
       else "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.png";
in
{
  programs.hyprlock = {
    enable = true;

    general = {
      disable_loading_bar = true;
      hide_cursor = false;
    };

    backgrounds = [
      {
        monitor = "eDP-1";
        # only png supported for now
        path = w1;
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 4; # 0 disables blurring
        blur_size = 2;
        noise = 0.0117;
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
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }
    ];

    input-fields = [
      {
        monitor = "eDP-1";
        size = {
          width = 1000;
          height = 200;
        };
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
        position = {
          x = 0;
          y = -300;
        };
        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        monitor = "eDP-1";
        text = "$TIME";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 350;
        inherit font_family;

        position = {
          x = 0;
          y = 400;
        };
        halign = "center";
        valign = "center";
      }
      {
        monitor = "eDP-1";
        text = "Hi, please enter the password...";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 75;
        inherit font_family;

        position = {
          x = 0;
          y = 0;
        };
        halign = "center";
        valign = "center";
      }
    ];
  };
}
