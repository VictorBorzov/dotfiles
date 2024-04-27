{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nix-output-monitor
    nvd
    p7zip
    eza # instead of ls
    git
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
    zellij
    restic # backups
    helix
    # xclip todo: add tools.x11 and tools.wayland
    # marksman
    nil
    haskellPackages.cabal-install
    # haskellPackages.stack
    ghc
# haskell.compiler.ghc96
    # cabal-install
    # haskell-language-server
    bat
    bc
    tldr
    gping
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "JetBrainsMono" ]; })
    # nerdfonts
    bottom # btop alternative, call btm
    # nodePackages.vscode-langservers-extracted
    cifs-utils
    zoxide
    coreutils
    emacs29-pgtk
    # ghostscript
    # pandoc
    dotnet-sdk_8
    # omnisharp-roslyn
    gnuplot
    # netcoredbg
    # (python3.withPackages (ps: with ps; [
    #   jupyter
    #   ipython
    #   matplotlib
    #   numpy
    #   googletrans
    #   wikipedia
    #   pandas
    #   jieba
    #   fugashi
    #   nltk
    # ]))
    # protobuf
    # go
    # gopls
    # texlive.combined.scheme-full
    # graphviz
  #   elmPackages.elm
  #   elmPackages.nodejs
  #   elmPackages.elm-format
  #   elmPackages.elm-language-server
  ];

  # Enable nerdfonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "emacsclient";
    # EDITOR = "emacs -nw"; # terminal emacs
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };


  # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
  # Folder reference also allows to mutate files
  home.file.".config/git".source = ./config/git;
  home.file."/home/vb/.emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink ./config/emacs/init.el;
  home.file.".config/helix".source = config.lib.file.mkOutOfStoreSymlink ./config/helix;
  home.file.".config/zellij".source = config.lib.file.mkOutOfStoreSymlink ./config/zellij;
  home.file.".config/ghc".source = ./config/ghc;

  # home.file.".doom.d/init.el".source = config.lib.file.mkOutOfStoreSymlink ./config/doom.d/init.el;
  # home.file.".doom.d/packages.el".source = config.lib.file.mkOutOfStoreSymlink ./config/doom.d/packages.el;
  # home.file.".doom.d/custom.el".source = config.lib.file.mkOutOfStoreSymlink ./config/doom.d/custom.el;
  # home.file.".doom.d/config.el".source = config.lib.file.mkOutOfStoreSymlink ./config/doom.d/config.el;

  home.file.".config/matplotlib/matplotlibrc".source = ./config/matplotlib/stylelib/rose-pine-dawn.mplstyle;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # optional for nix flakes support in home-manager 21.11, not required in home-manager unstable or 22.05
  # programs.direnv.nix-direnv.enableFlakes = true;

  programs.bash = {
   enable = true;
   bashrcExtra = ''
   PS1='\[\033[1;33m\]λ(\u@\h)\[\033[1;36m\].λ(\w)\[\033[1;35m\]$([ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ] && echo ".λ($(git rev-parse --abbrev-ref HEAD 2>/dev/null))")\[\033[0;37m\].λ \[\033[0;37m\]'

   alias rm='echo "Please use trash instead."; false'
   alias ls='eza --icons -F -H --group-directories-first --git -1'
   alias ll='ls -alF'
   alias lt='ls --tree'
   alias cat=bat
   alias cd=z
   alias zz='z -'
   eval "$(direnv hook bash)"
   eval "$(zoxide init bash)"
   '';
  };

  programs.bat = {
   enable = true;
   config.theme = "base16";# "OneHalfDark";
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };
}
