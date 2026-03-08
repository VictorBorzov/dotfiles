{ config, pkgs, ... }:

let
  mullvad-autostart = pkgs.makeAutostartItem {
    name = "mullvad-vpn";
    package = pkgs.mullvad-vpn;
  };
in
{

  services.mullvad-vpn = {
    package = pkgs.mullvad-vpn;
    enable = true;
  };
  environment.systemPackages = [ mullvad-autostart ];
}
