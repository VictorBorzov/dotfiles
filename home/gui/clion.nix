{ pkgs, ... }:
{
  home.packages = [ pkgs.jetbrains.clion ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/Clion${pkgs.jetbrains.clion.version}/clion64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}
