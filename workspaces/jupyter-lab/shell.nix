{ pkgs ? import <nixpkgs> {} }:
 let
    my-python-packages = ps: with ps; [
      pandas
      requests
    ];
  in
   pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    allowUnfree = true; 
    nativeBuildInputs = with pkgs.buildPackages; [
     jetbrains.dataspell
     # Defines a python + set of packages.
     (python3.withPackages (ps: with ps; with python3Packages; [
     jupyterlab
     ipython

     # Uncomment the following lines to make them available in the shell.
     pandas
     numpy
     matplotlib
     ]))
    ];
   shellHook = "jupyter-lab";
  }
