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

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;
  
  home.file.".config/nixpkgs".source = ./config/nixpkgs;
}
