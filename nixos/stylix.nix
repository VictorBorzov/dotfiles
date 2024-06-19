{ config, lib, pkgs, ... }:
{

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    enable = true;
    image = ../home/gui/pictures/dark-universe-2880x1800.png;


    cursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Snow";
      size = 22;
    };
 
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
        name = "Iosevka Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
        name = "Iosevka Nerd Font";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = config.stylix.fonts.sansSerif; 
    };
    fonts.sizes = {
      applications = 12;
      terminal = 18;
      desktop = 10;
      popups = 10;
    };
 
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
    };

  specialisation.light.configuration.stylix = {
    base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
  };
 
}
