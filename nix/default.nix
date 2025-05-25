{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nh.nix
  ];
  
  nixpkgs.config.allowUnfree = true;

  nix = {
    nixPath = [  "nixpkgs=${inputs.nixpkgs}" ];


  # nix-direnv
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
   '';
    
    settings.experimental-features = [ "nix-command" "flakes" ];

  };
}
