{ self, config, ... }:
let
  w1Dark =
    "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg";
  w1Light =
    "${config.home.homeDirectory}/dotfiles/home/gui/pictures/roses-2880x1800.jpg";

  w2Dark =
    "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg";
  w2Light =
    "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.jpg";
in {

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        (if true then w1Dark else w1Light)
        (if true then w2Dark else w2Light)
      ];
      wallpaper = [
        "eDP-1,${if true then w1Dark else w1Light}"
        "HDMI-A-1,${if true then w2Dark else w2Light}"
      ];
    };
  };
}
