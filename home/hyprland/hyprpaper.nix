{
  self,
  config,
  ...
}: let
  # w1Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/autumn-forest-trees-b9-2880x1800.jpg;";
  # w1Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg";
  w1Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/black.png";

  w2Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg";
  w2Light = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        w1Dark
        w2Dark
      ];
      wallpaper = [
        "eDP-1,${w1Dark}"
        "HDMI-A-1,${w2Dark}"
      ];
    };
  };
}
