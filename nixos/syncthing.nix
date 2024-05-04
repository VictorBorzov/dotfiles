{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
  #   openDefaultPorts = true;
  #   user = "vb";
  #   group = "users";
  #   guiAddress = "0.0.0.0:8384";
  #   configDir = "/home/vb/.config/syncthing";
  #   overrideDevices = true;
  #   overrideFolders = true;

  #   settings = {
  #     gui = {
  #           user = "username";
  #           password = "password";
  #     };
  #     devices = {
  #       "unicorn" = { id = "FI4TIMG-UPG5YKG-3SHCMNN-HI6H3HK-CDKIN3M-VELN7ZE-PCGDAJX-RGAJVA3"; };
  #     };
  #     folders = {
  #       "Sync" = {        
  #         path = "/home/vb/Sync";
  #         devices = [ "unicorn" ];
  #       };
  #     };
  #   };
  };

  # networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  # networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
