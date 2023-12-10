{ lib, config, pkgs, ... }:
{
 home.packages = with pkgs; [
    # zoom-us
    bitwarden
    wezterm
    webcord
    librewolf
    remmina
    slack
    telegram-desktop
    syncthing
    libreoffice
    mypaint
    krita
    fluidsynth
    jetbrains.rider
    # jetbrains.datagrip
    brave # for app mode
    vlc
    docker-compose
    jetbrains.dataspell
    # jetbrains.goland
    # postgresql
  ];

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/alacritty/alacritty.yml".source = ./config/alacritty/alacritty.yml;
  home.file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink ./config/wezterm/wezterm.lua;

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "librewolf.desktop" ];
        "application/x-extension-htm" = [ "librewolf.desktop" ];
        "application/x-extension-html" = [ "librewolf.desktop" ];
        "application/x-extension-shtml" = [ "librewolf.desktop" ];
        "application/x-extension-xht" = [ "librewolf.desktop" ];
        "application/x-extension-xhtml" = [ "librewolf.desktop" ];
        "application/x-extension-xhtml+xml" = [ "librewolf.desktop" ];
        "text/html" = [ "librewolf.desktop" ];
        "text/markdown" = [ "librewolf.desktop;" ];
        "text/plain" = [ "emacs.desktop" ];
        "video/*" = [ "vlc.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "audio/*" = [ "vlc.desktop" ];
        "x-scheme-handler/chrome" = [ "librewolf.desktop" ];
        "x-scheme-handler/ftp" = [ "librewolf.desktop" ];
        "x-scheme-handler/http" = [ "librewolf.desktop" ];
        "x-scheme-handler/https" = [ "librewolf.desktop" ];
        "x-scheme-handler/slack" = [ "slack.desktop" ];
        "x-scheme-handler/rdp" = [ "org.remmina.Remmina.desktop" ];
        "x-scheme-handler/spice" = [ "org.remmina.Remmina.desktop" ];
        "x-scheme-handler/vnc" = [ "org.remmina.Remmina.desktop" ];
        "x-scheme-handler/remmina" = [ "org.remmina.Remmina.desktop" ];
        "application/x-remmina" = [ "org.remmina.Remmina.desktop" ];
        "inode/directory" = [ "thunar.desktop;" ];
      };
    };
  };
}
