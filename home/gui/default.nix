{ inputs, lib, config, pkgs, ... }: {

  imports = [ ./foot.nix ./clion.nix ];

  home.packages = with pkgs; [
    xournalpp # to sign pdfs
    # libreoffice
    # yubikey-manager # For managing YubiKey settings
    # yubikey-personalization-gui #
    # yubioath-flutter
    zoom-us
    mullvad-browser
    librewolf
    telegram-desktop
    brave # for app mode
    vlc
#    vscode
#    obsidian
    code-cursor
    steam
    ticktick
    # syncthing
    # mypaint
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
