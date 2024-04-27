{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nh.nix
  ];
  
  nixpkgs.config.allowUnfree = true;

  nix = {
    nixPath = [  "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

  # nix-direnv
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
   '';
    
    settings.experimental-features = [ "nix-command" "flakes" ];

  };
}
