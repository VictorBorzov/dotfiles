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

  home.packages = with pkgs; [
    devs.helix
    devs.zellij
    devs.lf
    devs.emacs
    ledger
    wl-ocr
    nix-output-monitor
    nvd
    p7zip
    eza # instead of ls
    unzip
    delta
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
    haskellPackages.cabal-install
    ghc
    bat
    bc
    gping
    (nerdfonts.override {
      fonts = ["Iosevka" "IosevkaTerm" "JetBrainsMono"];
    })
    fira-code
    bottom # btop alternative, call btm
    cifs-utils
    zoxide
    coreutils
    gnuplot
    (with dotnetCorePackages; combinePackages [sdk_7_0 sdk_8_0])
    ghostscript
  ];

  # Enable nerdfonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    # EDITOR = "emacsclient -nw"; # terminal emacs
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    TLDR_AUTO_UPDATE_DISABLED = "1";
  };

  # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
  # Folder reference also allows to mutate files

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # initExtra = ''
    #   set -o vi
    # '';
    bashrcExtra = ''
      PS1='\[\033[1;33m\]λ(\u@\h)\[\033[1;36m\].λ(\w)\[\033[1;35m\]$([ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ] && echo ".λ($(git rev-parse --abbrev-ref HEAD 2>/dev/null))")\[\033[0;37m\].λ \[\033[0;37m\]'

      alias dp='${pkgs.dotnet-sdk_8}/bin/dotnet publish -c Release -r linux-x64 --self-contained=true -p:InvariantGlobalization=true -p:PublishTrimmed=true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=True -p:DebugType=None -p:DebugSymbols=False'

      alias rm='echo "Please use trash instead."; false'
      alias ls='eza --icons -F -H --group-directories-first --git -1'
      alias ll='ls -alF'
      alias lt='ls --tree'
      alias cat=bat
      alias cd=z
      alias zz='z -'
      eval "$(zoxide init bash)"
    '';
  };

  programs.bat = {
    enable = true;
  };

}
