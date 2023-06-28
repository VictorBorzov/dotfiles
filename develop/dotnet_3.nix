{ pkgs ? import <nixpkgs> {} }:
  let old_dotnet_pkgs = import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/73bc3300ad02be21998a7c0e987592ca66df73f3.tar.gz"; }) {};
  in
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    allowUnfree = true; 
    nativeBuildInputs = with pkgs.buildPackages; [
     jetbrains.rider
     old_dotnet_pkgs.dotnetCorePackages.sdk_3_0
     protobuf
    ];
  }
