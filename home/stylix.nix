{...}: {
  imports = [
    ../nixos/stylix.nix
  ];
  stylix = {
    targets = {
      zellij.enable = false;
      helix.enable = false;
    };
  };
}
