{
  description = "NixOS configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-colors = { url = "github:misterio77/nix-colors"; };
    stylix.url = "github:danth/stylix";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      # dark_mode = false;
      customHelix = import ./pkgs/helix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
      customZellij = import ./pkgs/zellij { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
      customLf = import ./pkgs/lf { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
    in
    {

      nixosConfigurations = {
        marshmallow = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./nix
            ./nixos
            ./hosts/asus-vivobook-m3401q
          ];
        };
      };

      # theme = { dark = dark_mode; };

      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        "vb@marshmallow" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs self customHelix customZellij customLf; };
          modules = [ ./home/vb.nix stylix.homeManagerModules.stylix ];
        };
        "borzov@ap-team.ru@borzov2" =
          home-manager.lib.homeManagerConfiguration {
            pkgs =
              nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = { inherit inputs self; };
            modules = [ ./home/borzov.ap-team.nix stylix.homeManagerModules.stylix ]; # Defined later
          };
      };

      apps.x86_64-linux = {
        lf = {
          type = "app";
          program = "${customLf}/bin/lf";
        };
        zellij = {
          type = "app";
          program = "${customZellij}/bin/zellij";
        };
        helix = {
          type = "app";
          program = "${customHelix}/bin/hx";
        };
      };

      devShells.x86_64-linux.dotnet = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          buildInputs =
            [ customHelix customZellij customLf dotnet-sdk_8 netcoredbg omnisharp-roslyn fsautocomplete ];
          shellHook = "zellij";
        };
      devShells.x86_64-linux.nix = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell { buildInputs = [ customHelix customZellij customLf nil ]; shellHook = "hx"; };
      devShells.x86_64-linux.go = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell { buildInputs = [ go gopls go-tools gotools delve customHelix customZellij customLf ]; shellHook = "hx"; };
      devShells.x86_64-linux.haskell = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          buildInputs = [
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server
            ghc
            customHelix
            customZellij
            customLf
          ];
          shellHook = "hx";
        };
    };
}
