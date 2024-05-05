{
  self,
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  w1Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-2880x1800.jpg";
  w1Light = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/roses-2880x1800.jpg";
  
  w2Dark = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/dark-universe-blue-1920x1080.jpg";
  w2Light = "${config.home.homeDirectory}/dotfiles/home/gui/pictures/pointoverhead-1920x1080.jpg";
in
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${w1Dark}
    preload = ${w1Light}
    preload = ${w2Dark}
    preload = ${w2Light}
    wallpaper = eDP-1,${if self.theme.dark then w1Dark else w1Light}
    wallpaper = HDMI-A-1,${if self.theme.dark then w2Dark else w2Light}
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
