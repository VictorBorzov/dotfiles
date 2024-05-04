{ inputs, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "vb";
  home.homeDirectory = "/home/vb";
  home.stateVersion = "23.05";

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./cli
    ./gui
    ./hyprland
  ];


  colorScheme = if inputs.myConfig.theme.dark
                then inputs.nix-colors.colorSchemes.rose-pine-moon
                else inputs.nix-colors.colorSchemes.rose-pine-dawn;
  

  home.file.".config/nixpkgs".source = ./config/nixpkgs;
}
