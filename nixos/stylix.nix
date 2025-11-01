{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pop.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/bright.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/isotope.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-black.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pico.yaml";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-gorgoroth.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    enable = true;
    polarity = "dark";
    image = ../home/gui/pictures/black.png;
    # image = ../home/gui/pictures/dark-universe-2880x1800.jpg;
    # image = ../home/gui/pictures/autumn-forest-trees-b9-2880x1800.jpg;
    # image = ../home/gui/pictures/azul-2880x1800.jpg;

    cursor = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Snow";
      size = 18;
    };

    fonts = {
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = config.stylix.fonts.sansSerif;
    };
    fonts.sizes = {
      applications = 10;
      terminal = 12;
      desktop = 10;
      popups = 10;
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 0.9;
      popups = 1.0;
    };
  };

  # specialisation.light.configuration.stylix = {
  #   base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
  # };
}
