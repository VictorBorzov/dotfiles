let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.vb = { config, pkgs, ... }: {
     nixpkgs.config.allowUnfree = true;

     home.username = "vb";
     home.homeDirectory = "/home/vb";
     home.stateVersion = "23.05";

     imports = [
      ./home.apps.cli.nix
      ./home.apps.gui.nix 
    ];

     home.packages = with pkgs; [];

     # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
     # Folder reference also allows to mutate files
     home.file.".config/nixpkgs".source = ./config/nixpkgs;
  };
}
