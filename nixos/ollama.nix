{
  lib,
  config,
  pkgs,
  inputs,
  ...
} :
let
  ollamapkgs = import inputs.ollama { system = "x86_64-linux"; config.allowUnfree = true; };
in
{

  systemd.services.ollama.wantedBy = lib.mkForce [];
  systemd.services.open-webui.wantedBy = lib.mkForce [];

  services.ollama = {
    enable = true;
    package = ollamapkgs.ollama-cuda;
    acceleration = "cuda";
    loadModels = ["mistral:7b"];
  };

  services.open-webui = {
    package = ollamapkgs.open-webui;
    enable = true;
    port = 8083;
  };
}
