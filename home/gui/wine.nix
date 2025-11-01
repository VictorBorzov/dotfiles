
{ inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
  home.sessionVariables = {
    WINEPREFIX = "${config.home.homeDirectory}/.wine-kindle";
  };
}
