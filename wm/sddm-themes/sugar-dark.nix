{ pkgs }:

let
  imgLink = "/home/vb/dotfiles/pictures/dark-serbian-building-2880x1800.jpg";
in
pkgs.stdenv.mkDerivation {
  name = "sddm-sugar-dark";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
    installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    ln -s ${imgLink} $out/Background.jpg
   '';
}
