{ pkgs, inputs, ... }: {
  imports = [
    pkgs.callPackage ./wl-ocr {};
  };
}
