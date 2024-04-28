{
  description = "A nixos container with a k3s service";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        defaultPackage = pkgs.nixosContainer {
          name = "k3s";
          config = { config, pkgs, ... }: {
            boot.isContainer = true;
            networking.firewall.enable = false;
            services.k3s = {
              enable = true;
              extraFlags = "--write-kubeconfig-mode 644";
            };
          };
        };
      }
    );
}
