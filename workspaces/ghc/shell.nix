{ pkgs ? import <nixpkgs> {} }:
  let
     old_pkgs = import (builtins.fetchGit {
         # Descriptive name to make the store path easier to identify
         name = "my-old-revision";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixpkgs-unstable";
         rev = "e10001042d6fc2b4246f51b5fa1625b8bf7e8df3";
     }) {};
  in
  pkgs.mkShell {
    nativeBuildInputs = [old_pkgs.ghc.ghc782];
  }
