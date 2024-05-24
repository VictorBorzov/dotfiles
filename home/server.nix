{ self, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.05";

  imports = [ inputs.nix-colors.homeManagerModules.default ./cli ];

  colorScheme = if self.theme.dark then
    inputs.nix-colors.colorSchemes.rose-pine-moon
  else
    inputs.nix-colors.colorSchemes.rose-pine-dawn;
}

