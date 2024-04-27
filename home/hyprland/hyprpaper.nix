{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  w1 = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg";
  w2 = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg";
in
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${w1}
    preload = ${w2}
    wallpaper = eDP-1,${w1}
    wallpaper = HDMI-A-1,${w2}
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe inputs.hyprpaper.packages.${pkgs.system}.default}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
