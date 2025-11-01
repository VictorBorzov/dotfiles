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
	 # boot.kernelParams = [
	 #   "usbcore.usb3=0"
	 #   "usbcore.autosuspend=-1"
	 #   "usbcore.quirks=13d3:5458:k"
	 # ];
	 # services.udev.extraRules = ''
	 #   ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="13d3", ATTR{idProduct}=="5458", TEST=="power/control", ATTR{power/control}="on"
	 # '';
	 # services.logind.extraConfig = ''
	 #   HandleLidSwitch=ignore
	 #   HandleLidSwitchDocked=ignore
	 #   HandleLidSwitchExternalPower=ignore
	 # '';
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

	# services.xserver.videoDrivers = [ "nvidia" ];

	# hardware.nvidia = {
 	#   modesetting.enable = true;       # Required for KMS, Wayland, Xorg on NVIDIA
 	#   open = false;                    # Use closed-source driver for CUDA compatibility, recommended for RTX 30 series :contentReference[oaicite:2]{index=2}
 	#   nvidiaSettings = true;          # Enables `nvidia-settings` utility :contentReference[oaicite:3]{index=3}
 	#   package = config.boot.kernelPackages.nvidiaPackages.stable;  # Ensures proper kernel module version :contentReference[oaicite:4]{index=4}

 	#   prime = {
 	#     offload.enable = true;
 	#     intelBusId = "PCI:4:0:0";
 	#     nvidiaBusId = "PCI:1:0:0";
 	#   };

 	#   # Optional power‑management tweaks
 	#   powerManagement.enable = false;
 	#   powerManagement.finegrained = false;
 	# };

 	# -> power saving
  services.auto-cpufreq.enable = true;
	powerManagement = {
    enable = true;
    powertop = {
      enable = true;
    };
    cpuFreqGovernor = "powersave"; # or "schedutil"
  };

  services.tlp = {
    enable = true;
    settings = {
      # CPU scaling
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Intel P-state or AMD equivalents
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # PCIe autosuspend
      PCIE_ASPM_ON_AC = "powersave";
      PCIE_ASPM_ON_BAT = "powersave";

      # USB autosuspend
      USB_AUTOSUSPEND = 1;

      # Runtime power management for PCI
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # Optional: disable turbo boost
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;

 
      CPU_MIN_PERF_ON_AC = 10;
      CPU_MAX_PERF_ON_AC = 50;

      CPU_MIN_PERF_ON_BAT = 5;
      CPU_MAX_PERF_ON_BAT = 40;


     # Radeon integrated graphics
      RADEON_POWER_PROFILE_ON_AC  = "low";
      RADEON_POWER_PROFILE_ON_BAT = "low";

      RADEON_DPM_STATE_ON_AC  = "battery";
      RADEON_DPM_STATE_ON_BAT = "battery";
 
    };
  };
  zramSwap.enable = true;
  # Optional: Enable fan control (if thinkfan or EC support is available)
  services.thinkfan = {
    enable = true;
    smartSupport = true;
  };
 	# <- power saving

  
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
    extraGroups = ["audio" "networkmanager" "wheel" "video" "wireshark" "input" "kvm" "libvirtd" ];
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
    man.generateCaches = true;
  };

  environment.systemPackages = with pkgs; [ man-pages man-pages-posix stdman llvmPackages.lldb-manpages wireshark virt-manager virt-viewer ];

  environment.wordlist.enable = true;
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
  };

  virtualisation.libvirtd.enable = true;
#  virtualisation.docker.enable = true;

  # Optional: reduce surprises from automounters
  services.udisks2.enable = false;
  services.gvfs.enable = false;



  services.pcscd.enable = true;

  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 8083 ];
  system.stateVersion = "23.05";
}
