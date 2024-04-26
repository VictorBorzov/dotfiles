{ inputs, config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "vb";
  home.homeDirectory = "/home/vb";
  home.stateVersion = "23.05";

  imports = [
    ./cli
    ./gui
    ./hyprland
  ];

  home.file.".config/nixpkgs".source = ./config/nixpkgs;
}
