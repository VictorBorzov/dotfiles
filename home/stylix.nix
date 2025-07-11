{...}: {
  imports = [
    ../nixos/stylix.nix
  ];
  stylix = {
    targets = {
      emacs.enable = false;
      helix.enable = false;
      hyprlock.enable = false;
    };
  };
}
