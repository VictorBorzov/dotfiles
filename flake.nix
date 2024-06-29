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
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.vb = import ./home/vb.nix;
          #   home-manager.extraSpecialArgs = {inherit inputs;};
          #   home-manager.sharedModules = [
          #     {
          #       stylix.targets.zellij.enable = false;
          #       stylix.targets.helix.enable = false;
          #       # stylix.targets.waybar.enable = false;
          #     }
          #   ];
          # }
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

      "borzov@ap-team.ru@borzov2" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs self;};
        modules = [./home/borzov.ap-team.nix stylix.homeManagerModules.stylix]; # Defined later
      };
    };
  };
}
