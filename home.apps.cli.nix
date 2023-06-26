{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    git
    delta
    pv
    zellij
    helix
    xclip
    marksman
    nil
    ghc
    haskell-language-server
    bat
    bc
    tldr
    dotnet-sdk_7
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    btop
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
  home.file.".config/helix".source = config.lib.file.mkOutOfStoreSymlink ./config/helix;
  home.file.".config/zellij".source = ./config/zellij;
  home.file.".config/btop".source = ./config/btop;
  home.file.".config/ghc".source = /home/vb/dotfiles/config/ghc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
   enable = true;
   bashrcExtra = ''
   PS1='\[\033[1;35m\]λ(\u@\h)\[\033[1;32m\].λ(\w)\[\033[1;33m\]$([ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ] && echo ".λ($(git rev-parse --abbrev-ref HEAD 2>/dev/null))")\[\033[0;37m\].λ \[\033[0;37m\]'
   '';
  };

  programs.bat = {
   enable = true;
   config.theme = "gruvbox-light";
  };
}
