{
  description = "NixOS configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = { url = "github:misterio77/nix-colors"; };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      marshmallow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./nix ./nixos ./hosts/asus-vivobook-m3401q ];
      };
    };

    theme = { dark = false; };

    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    apps.x86_64-linux.helix = {
      type = "app";
      program = "${self.homeConfigurations."vb@marshmallow".pkgs.helix}/bin/hx";
    };

    homeConfigurations = {
      "vb@marshmallow" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs self; };
        modules = [ ./home/vb.nix ]; # Defined later
      };
      "borzov@borzov2.ap-team.ru" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs self; };
        modules = [ ./home/server.nix ]; # Defined later
      };
    };
  };
}
