{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./vpn.mullvad.nix
    ./stylix.nix
    ./greetd.nix
    ./hyprland.nix
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 42;

  # laptop camera fix ->
  boot.kernelParams = [
    "usbcore.usb3=0"
    "usbcore.autosuspend=-1"
    "usbcore.quirks=13d3:5458:k"
  ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="13d3", ATTR{idProduct}=="5458", TEST=="power/control", ATTR{power/control}="on"
  '';
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=ignore
  '';
  # <- laptop camera fix

  # Setup keyfile
  boot.initrd.secrets = {"/crypto_keyfile.bin" = null;};

  # Enable swap on luks
  boot.initrd.luks.devices."luks-6831d591-ca24-46d4-9359-aa5c6bf9e2eb".device = "/dev/disk/by-uuid/6831d591-ca24-46d4-9359-aa5c6bf9e2eb";
  boot.initrd.luks.devices."luks-6831d591-ca24-46d4-9359-aa5c6bf9e2eb".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "marshmallow"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Belgrade";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.pulseaudio.enable = false;
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;       # Required for KMS, Wayland, Xorg on NVIDIA
    open = false;                    # Use closed-source driver for CUDA compatibility, recommended for RTX 30 series :contentReference[oaicite:2]{index=2}
    nvidiaSettings = true;          # Enables `nvidia-settings` utility :contentReference[oaicite:3]{index=3}
    package = config.boot.kernelPackages.nvidiaPackages.stable;  # Ensures proper kernel module version :contentReference[oaicite:4]{index=4}

    prime = {
      offload.enable = true;
      intelBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Optional power‑management tweaks
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # power saving
  services.power-profiles-daemon.enable = true;

  hardware.opengl.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vb = {
    isNormalUser = true;
    description = "vb";
    extraGroups = ["audio" "networkmanager" "wheel" "video" "wireshark"];
  };

  documentation = {
    enable = true;
    # dev.enable = true;
    # man.enable = true;
    # man.generateCaches = true;
  };

  environment.systemPackages = with pkgs; [ man-pages man-pages-posix stdman llvmPackages.lldb-manpages wireshark ];

  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
  };
#  virtualisation.docker.enable = true;

  services.pcscd.enable = true;

  networking.firewall.enable = true;

  system.stateVersion = "23.05";
}
