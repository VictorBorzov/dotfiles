{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    allowUnfree = true; 
    nativeBuildInputs = with pkgs.buildPackages; [
     jetbrains.rider
     dotnet-sdk
     protobuf
    ];

    shellHook = ''
      nohup rider &
    '';
  }
