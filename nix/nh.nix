{pkgs, ...}: {
  # nh default flake
  environment.variables.FLAKE = "/home/vb/dotfiles";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
