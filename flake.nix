{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dev.url = "gitlab:victorborzov/dev";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      marshmallow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nix
          ./nixos
          ./hosts/asus-vivobook-m3401q
          stylix.nixosModules.stylix
        ];
      };
    };

    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "vb@marshmallow" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs self;};
        modules = [./home/vb.nix stylix.homeManagerModules.stylix];
      };
    };
  };
}
