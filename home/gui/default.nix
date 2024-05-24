{ lib, config, pkgs, ... }: {
  imports = [ ./kitty.nix ];

  home.packages = with pkgs; [
    xournal # to sign pdfs
    mullvad-browser
    # yubikey-manager # For managing YubiKey settings
    # yubikey-personalization-gui #
    # yubioath-flutter
    librewolf
    remmina
    slack
    telegram-desktop
    syncthing
    libreoffice
    mypaint
    brave # for app mode
    vlc
    docker-compose
    jetbrains.rider
  ];

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=50
    text_font=sans-serif
    paint_mode=brush
    early_exit=false
    fill_shape=false
  '';

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
