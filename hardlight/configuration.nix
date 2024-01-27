{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      "${modulesPath}/installer/sd-card/sd-image-aarch64-new-kernel-no-zfs-installer.nix"
      ../modules/common.nix
    ];

  nixpkgs.hostPlatform = "aarch64-linux";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  boot.tmp.useTmpfs = true;

  services.journald.storage = "none"; #volatile

  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # List services that you want to enable:
  zramSwap.enable = true;

  services.golightctrl = {
    enable = true;
    settings = {
      GOLIGHTCTRL_MQTTBROKER="tcp://mqtt.realraum.at:1883";
      GOLIGHTCTRL_RF433TTYDEV="/dev/ttyRF433";
      GOLIGHTCTRL_BUTTONTTYDEV="/dev/ttyButtons";
    };
  };


  services.udev.extraRules = ''
  ## teensy rules and device names
  ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{ID_MM_DEVICE_IGNORE}="1"
  ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{MTP_NO_PROBE}="1"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", MODE:="0666"
  KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ATTRS{idUsbInterfaceNum}=="00", SYMLINK+="ttyRF433", MODE:="0666"
  KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ATTRS{idUsbInterfaceNum}=="02", SYMLINK+="ttyButtons", MODE:="0666"

  ## gpio permissions
  ### TODO: see https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_4#Using_GPIO_pins_as_non_root
  SUBSYSTEM=="gpio*", PROGRAM="/bin/sh -c 'chown -R root:gpio /sys/class/gpio && chmod -R 770 /sys/class/gpio; chown -R root:gpio /sys/devices/virtual/gpio && chmod -R 770 /sys/devices/virtual/gpio; chown -R root:gpio /sys/devices/platform/soc/*.gpio/gpio && chmod -R 770 /sys/devices/platform/soc/*.gpio/gpio'"
  SUBSYSTEM=="bcm2835-gpiomem", GROUP="gpio", MODE="0660"
  '';

  networking = let 
    raspiIF = "enu1u1u1";
    in 
    {
      interfaces.${raspiIF}.ipv4.addresses = [{
        address = "192.168.33.10";
        prefixLength = 24;
      }];
      defaultGateway = {
        address = "192.168.33.1";
        interface = raspiIF;
      };
      hostName = "r3-hardlight"; # Define your hostname.
      wireless.enable = mkForce false;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = mkForce false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  mkg.mod = {
    yggdrasil = {
      enable = true;
      port = 17858;
      peers = [ "tcp://ygg.mkg20001.io:80" "tls://ygg.mkg20001.io:443" ];
    };
  };

}
