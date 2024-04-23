{ lib, config, pkgs, ... }:
{
 home.packages = with pkgs; [
    # zoom-us

    # simplex-chat-desktop
    xournal # to sign pdfs
    mullvad-browser
    # libyubikey
    yubikey-manager # For managing YubiKey settings
    yubikey-personalization-gui #
    yubioath-flutter
    # bitwarden
    wezterm
    # webcord
    librewolf
    remmina
    slack
    telegram-desktop
    syncthing
    libreoffice
    mypaint
    # krita
    jetbrains.rider
    # jetbrains.datagrip
    brave # for app mode
    vlc
    docker-compose
    # jetbrains.dataspell
    # postgresql
  ];

  # Add config.lib.file.mkOutOfStoreSymlink before reference to make it mutable by symlink
  home.file.".config/alacritty/alacritty.yml".source = ./config/alacritty/alacritty.yml;
  home.file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink ./config/wezterm/wezterm.lua;
  home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./config/kitty/kitty.conf;
  home.file.".config/kitty/dark.conf".source = ./config/kitty/dark.conf;
  home.file.".config/kitty/light.conf".source = ./config/kitty/light.conf;

  home.file.".config/background.jpg".source = ./pictures/roses.jpg;
  home.file.".config/background-dark.jpg".source = ./pictures/dark-universe-2880x1800.jpg;


  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "mullvad-browser.desktop" ];
        "application/x-extension-htm" = [ "mullvad-browser.desktop" ];
        "application/x-extension-html" = [ "mullvad-browser.desktop" ];
        "application/x-extension-shtml" = [ "mullvad-browser.desktop" ];
        "application/x-extension-xht" = [ "mullvad-browser.desktop" ];
        "application/x-extension-xhtml" = [ "mullvad-browser.desktop" ];
        "application/x-extension-xhtml+xml" = [ "mullvad-browser.desktop" ];
        "text/html" = [ "mullvad-browser.desktop" ];
        "text/markdown" = [ "mullvad-browser.desktop;" ];
        "text/plain" = [ "emacs.desktop" ];
        "video/*" = [ "vlc.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "audio/*" = [ "vlc.desktop" ];
        "x-scheme-handler/chrome" = [ "mullvad-browser.desktop" ];
        "x-scheme-handler/ftp" = [ "mullvad-browser.desktop" ];
        "x-scheme-handler/http" = [ "mullvad-browser.desktop" ];
        "x-scheme-handler/https" = [ "mullvad-browser.desktop" ];
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
