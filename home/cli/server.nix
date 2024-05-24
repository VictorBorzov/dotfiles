{ self, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  imports = [ ./helix ./git ./lf ];

  home.packages = with pkgs; [
    nix-output-monitor
    nvd
    p7zip
    eza # instead of ls
    unzip
    delta
    wget
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
    nil
    bat
    bc
    tldr
    gping
    (nerdfonts.override {
      fonts = [ "Iosevka" "IosevkaTerm" "JetBrainsMono" ];
    })
    bottom # btop alternative, call btm
    cifs-utils
    zoxide
    coreutils
    emacs29-pgtk
    (with dotnetCorePackages; combinePackages [ sdk_7_0 sdk_8_0 ])
  ];

  # Enable nerdfonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "emacs -nw"; # terminal emacs
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  # Add config.lib.file.mkOutOfStoreSymlink to make config file just symlink to the origin
  # Folder reference also allows to mutate files
  home.file."/home/vb/.emacs.d/init.el".source =
    config.lib.file.mkOutOfStoreSymlink ./config/emacs/init.el;
  home.file.".config/zellij".source =
    config.lib.file.mkOutOfStoreSymlink ./config/zellij;

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
    config.theme = if self.theme.dark then "OneHalfDark" else "base16";
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };
}
