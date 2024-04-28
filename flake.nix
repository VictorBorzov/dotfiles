{
  description = "NixOS configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock.url = "github:hyprwm/hyprlock";

    hyprpaper.url = "github:hyprwm/hyprpaper";    

    hypridle.url = "github:hyprwm/hypridle";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      marshmallow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nix
          ./nixos
          ./hosts/asus-vivobook-m3401q
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vb = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs self; };
          }
        ];
      };
    };
    templates = {
      aspnet = {
        path = ./templates/aspnet;
        description = "Dotnet web application template";
      };
      dotnet = {
        path = ./templates/dotnet;
        description = "Dotnet application template";
      };
    };
    
  };
}
