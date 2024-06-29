{...}: {
  nixpkgs.config.allowUnfree = true;

  home.username = "vb";
  home.homeDirectory = "/home/vb";
  home.stateVersion = "23.05";

  imports = [
    ./cli
    ./gui
    ./hyprland
    ./stylix.nix
  ];
}
