{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils pkgs.update-systemd-resolved ];

  # Openvpn 
  services.openvpn.servers = {
    officeVPN  = {
      config = ''
        config /home/vb/.secrets/pfSense-TCP4-443-borzov-config.ovpn

        script-security 2
        up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
        up-restart
        down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
        down-pre
        dhcp-option DOMAIN AP-TEAM.RU #доменные суффиксы
        dhcp-option DOMAIN MRS.AP
        dhcp-option DOMAIN MCS.AP
      '';
      updateResolvConf = true;
      # autoStart = false;
    };
   };

  # For mount.cifs, required unless domain name resolution is not needed.
  # fileSystems."/mnt/ap-storage-algs" = {
  #   device = "//ap-team.ru/storage";
  #   fsType = "cifs";
  #   options = let
  #      ## this line prevents hanging on network split
  #      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=openvpn-officeVPN.service";
  #     in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };

  fileSystems."/mnt/tmp" = {
    device = "//ap-team.ru/storage";
    fsType = "cifs";
    options = [
     "x-systemd.requires=openvpn-officeVPN.service"
     "credentials=/etc/nixos/smb-secrets"
     "x-systemd.automount"
     "noauto"
   ];
  };

}
