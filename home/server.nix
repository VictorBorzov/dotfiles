{ self, inputs, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.username = "borzov";
  home.homeDirectory = "/home/borzov";
  home.stateVersion = "23.05";

  imports = [ inputs.nix-colors.homeManagerModules.default ./cli ];

  colorScheme = if self.theme.dark then
    inputs.nix-colors.colorSchemes.rose-pine-moon
  else
    inputs.nix-colors.colorSchemes.rose-pine-dawn;
}

