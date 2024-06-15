{ self, inputs, config, pkgs, stylix, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "vb";
  home.homeDirectory = "/home/vb";
  home.stateVersion = "23.05";

  imports = [
    # inputs.nix-colors.homeManagerModules.default
    ./cli
    ./gui
    ./hyprland
  ];


  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.enable = true;
  stylix.image = ./gui/pictures/dark-universe-2880x1800.png;

  # colorScheme = if self.theme.dark
  #               then inputs.nix-colors.colorSchemes.rose-pine-moon
  #               else inputs.nix-colors.colorSchemes.rose-pine-dawn;
}
