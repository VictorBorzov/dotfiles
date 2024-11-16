{
  self,
  config,
  ...
}: let
  w1Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg";

  w1Light = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/azul-2880x1800.jpg";

  w2Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg";
  w2Light = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        w1Light
        w2Light
      ];
      wallpaper = [
        "eDP-1,${w1Light}"
        "HDMI-A-1,${w2Light}"
      ];
    };
  };
}
