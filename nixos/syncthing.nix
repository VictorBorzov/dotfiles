{
  lib,
  config,
  pkgs,
  inputs,
  ...
} :
{

  services.syncthing = {
    enable = true;
    systemService = false;
  };

  systemd.services.syncthing.wantedBy = lib.mkForce [];
}
