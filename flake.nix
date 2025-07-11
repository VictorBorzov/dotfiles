{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";

    hyprland.url = "github:hyprwm/Hyprland";

    dev.url = "gitlab:victorborzov/dev";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    {

      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      nixosConfigurations = {
        marshmallow = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./nix
            ./nixos
            ./hosts/asus-vivobook-m3401q
            stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        "vb@marshmallow" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./home/vb.nix
            stylix.homeManagerModules.stylix
          ];
        };
      };

      devShells.x86_64-linux = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      in {
        qt = pkgs.mkShell {
          buildInputs = with pkgs; [
            # gcc
            # qtcreator
            qt6.qtbase
            # qt6.qtdeclarative
            qt6.qttools
            qt6.qtsvg
            qt6.wrapQtAppsHook
            cmake
            ninja
            gdb
            makeWrapper
          ];
        };
      };

    };
}
