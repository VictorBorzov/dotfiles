{
  pkgs,
  lib,
  config,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  # screen idle
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
        afterSleepCmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 120;
          onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
