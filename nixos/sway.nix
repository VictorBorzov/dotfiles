{ pkgs, inputs, ... }:

{
  security.pam.services.swaylock = {};

  programs.sway = {
      package = pkgs.sway;
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  
  hardware = {
    opengl = {
      enable = true;

      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    nvidia.modesetting.enable = true;
  };



  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.light.enable = true;
  programs.nm-applet.enable = true;
  services.blueman.enable = true;


  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # from sway nixos https://nixos.wiki/wiki/Sway
  security.polkit.enable = true;
}
