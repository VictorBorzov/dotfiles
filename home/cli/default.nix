{
  self,
  config,
  pkgs,
  inputs,
  ...
}: let
  wl-ocr = pkgs.callPackage ../../pkgs/wl-ocr {};
  devs = inputs.dev.packages."x86_64-linux";
in {
  nixpkgs.config.allowUnfree = true;

  imports = [./git ./tealdeer];

  services.emacs = {
    enable = true;
    package = devs.emacs;
    client.arguments = [ "-c" ];
  };
  home.packages = with pkgs; [
    file # educated guess about file type
    wirelesstools # iwconfig <network>
    valgrind
    kdePackages.kcachegrind
    dig # dns lookup utils
    mailutils # ?
    ed
    pstree
    vim-full
    ltrace
    devs.vmrss
    devs.emacs
    pinentry-tty
    # devs.zellij
    glibc.static
    gdb
    ledger
    wl-ocr
    nix-output-monitor
    nvd
    p7zip
    eza # instead of ls
    unzip
    # delta
    dust # instead of du
    sd # instead of sed
    procs # instead of ps
    # bandwhich # network
    hyperfine # benchmark
    wthrr # weather like wthrr belgrade -f d
    wget
    cmake
    gcc
    gnumake
    libtool
    ripgrep
    fd
    entr
    fzf
    trashy # instead of rm
    imgcat # terminal image viewer
    pv
    restic # backups
    nil
    alejandra
    bat
    bc
    gping
    iosevka
    fira-code
    bottom # btop alternative, call btm
    cifs-utils
    zoxide
    coreutils
    gnuplot
  ];

  # Enable nerdfonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    # EDITOR = "hx";
    # EDITOR = "emacsclient -nw"; # terminal emacs
    # DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    TLDR_AUTO_UPDATE_DISABLED = "1";
  };

  # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
  # Folder reference also allows to mutate files

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
                allow-emacs-pinentry
                '';
    pinentryPackage = pkgs.pinentry-tty;
    verbose = true;
  };

  programs.gpg.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # initExtra = ''
    #   set -o vi
    # '';
    bashrcExtra = ''
      alias rm='echo "Please use trash instead."; false'
      # alias ls='eza --icons -F -H --group-directories-first --git -1'
      # alias ll='ls -alF'
      # alias lt='ls --tree'
      # alias cat=bat
      # alias cd=z
      # alias zz='z -'
      eval "$(zoxide init bash)"
    '';

    profileExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec sway
    '';
  };

  programs.bat = {
    enable = true;
  };

}
