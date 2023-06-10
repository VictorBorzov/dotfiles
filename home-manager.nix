{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
     (import "${home-manager}/nixos")
  ];

  home-manager.users.vb = {

     home.username = "vb";
     home.homeDirectory = "/home/vb";
     home.stateVersion = "23.05";

     home.packages = with pkgs; [
        git
        delta
        tmux
        helix
        gcc
        xclip
        marksman
        nil
        ghc
        haskell-language-server
        bat
        tldr
        alacritty
        bitwarden
        librewolf
        mullvad-vpn
        jetbrains.rider
        dotnet-sdk_7
        remmina
        slack
        telegram-desktop
        syncthing
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        btop
     ];

     # Enable nerdfonts
     fonts.fontconfig.enable = true;

     home.sessionVariables = {
       EDITOR = "hx";
     };


     home.file.".config/git".source = /home/vb/dotfiles/config/git;
     home.file.".config/alacritty/alacritty.yml".source = /home/vb/dotfiles/config/alacritty/alacritty.yml;
     home.file.".config/helix/config.toml".source = /home/vb/dotfiles/config/helix/config.toml;
     home.file.".config/helix/languages.toml".source = /home/vb/dotfiles/config/helix/languages.toml;
     home.file.".config/helix/themes".source = /home/vb/dotfiles/config/helix/themes;
     home.file.".config/tmux".source = /home/vb/dotfiles/config/tmux;
     home.file.".config/btop".source = /home/vb/dotfiles/config/btop;
     home.file.".config/ghc/ghci.conf".source = /home/vb/dotfiles/config/ghci/ghci.conf;

     programs.home-manager.enable = true;

     programs.bash = {
       enable = true;
       bashrcExtra = ''
       PS1='🐶\[\033[1;37m\]:\w\[\033[1;35m\]$([ -d .git ] && echo " ($(git branch 2>/dev/null | grep -e "^*" | sed "s/^* //"))")\[\033[1;37m\]|> \[\033[0;37m\]'
       '';
    };

     programs.bat = {
       enable = true;
       config.theme = "gruvbox-light";
     };

  };
}
