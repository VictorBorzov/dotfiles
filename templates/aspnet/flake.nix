{
  description = "Dotnet app build";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
   {
    packages.x86_64-linux.default = pkgs.buildDotnetModule {
      pname = "HelloWorld";
      version = "0.1";
      src = ./.;
      projectFile = "./HelloWorld.csproj";
      nugetDeps = ./deps.nix;
      dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0_1xx;
      dotnet-runtime = pkgs.dotnetCorePackages.dotnet_8.aspnetcore;
      executables = [ "HelloWorld" ];
    };
  };
}

