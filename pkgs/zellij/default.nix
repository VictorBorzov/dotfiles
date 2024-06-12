{ pkgs, dark ? false }:
let
  configFile = pkgs.writeText "config.kdl" ''
      themes {
       rose-pine-dawn {
        bg "#faf4ed"
        fg "#575279"
        red "#b4637a"
        green "#286983"
        blue "#56949f"
        yellow "#ea9d34"
        magenta "#907aa9"
        orange "#fe640b"
        cyan "#d7827e"
        black "#f2e9e1"
        white "#575279"
       }
      
       rose-pine-moon {
        bg "#232136"
        fg "#e0def4"
        red "#eb6f92"
        green "#3e8fb0"
        blue "#9ccfd8"
        yellow "#f6c177"
        magenta "#c4a7e7"
        orange "#fe640b"
        cyan "#ea9a97"
        black "#393552"
        white "#e0def4"
       }
      }
      theme "${if dark then "rose-pine-moon" else "rose-pine-dawn"}"
      // default_layout "compact"
      // pane_frames false
  '';

  zellijWrapper = pkgs.stdenv.mkDerivation {
    name = "zellij-wrapper";
    buildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.zellij}/bin/zellij $out/bin/zellij \
        --add-flags "--config ${configFile}"
    '';
  };
in
zellijWrapper

