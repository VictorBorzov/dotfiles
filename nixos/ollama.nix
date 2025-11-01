{
  lib,
  config,
  pkgs,
  inputs,
  ...
} :
let
  ollamapkgs = import inputs.nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };
in
{

  services.ollama = {
    enable = true;
    package = ollamapkgs.ollama-cuda;
    acceleration = "cuda";
    loadModels = ["mistral:7b"];
  };

  services.open-webui = {
    package = ollamapkgs.open-webui;
    enable = true;
    host = "0.0.0.0";
    port = 8083;
    environment = {
      ENABLE_WEB_SEARCH = "True";
 		  WEB_SEARCH_ENGINE = "duckduckgo";
      WEB_SEARCH_CONCURRENT_REQUESTS = "1";
      WEB_SEARCH_RESULT_COUNT = "1";
      ANONYMIZED_TELEMETRY = "False";
 		  DO_NOT_TRACK = "True";
 		  SCARF_NO_ANALYTICS = "True";
    };
  };

  systemd.services.ollama.wantedBy = lib.mkForce [];
  systemd.services.open-webui.wantedBy = lib.mkForce [];
}
