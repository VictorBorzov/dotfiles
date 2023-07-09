{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    exa # instead of ls
    git
    delta
    trashy # instead of rm
    imgcat # terminal image viewer
    pv
    zellij
    restic # backups
    helix
    xclip
    marksman
    nil
    ghc
    haskell-language-server
    bat
    bc
    tldr
    gping
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nerdfonts
    bottom # btop alternative, call btm
    nodePackages.vscode-langservers-extracted
    cifs-utils
  ];

  # Enable nerdfonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
   EDITOR = "hx";
  };


  # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
  # Folder reference also allows to mutate files
  home.file.".config/git".source = ./config/git;
  home.file.".config/helix".source = ./config/helix;
  home.file.".config/zellij".source = ./config/zellij;
  home.file.".config/ghc".source = ./config/ghc;
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
   alias ls='exa --icons -F -H --group-directories-first --git -1'
   alias ll='ls -alF'
   alias lt='ls --tree'
   alias cat=bat
   eval "$(direnv hook bash)"
   '';
  };

  programs.bat = {
   enable = true;
   config.theme = "gruvbox-light";
  };
}
