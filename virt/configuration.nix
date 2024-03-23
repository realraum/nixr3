# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: with lib; {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../modules/common.nix
    ./incus.nix
    ./nginx.nix
    #../modules/qemu-base.nix
  ];

  virtualisation.incus.enable = true;
  virtualisation.incus.ui.enable = true;
  services.fwupd.enable = true;

  networking.useDHCP = mkForce false;
  # networking.interfaces.enp1s0.useDHCP = true;

  systemd.network = {
    enable = true;
    networks."40-enp1s0" = {
      matchConfig = {
        Name = "enp1s0";
      };
      gateway = [ "192.168.127.254" ];
      networkConfig = {
      };
      addresses = [
        { addressConfig = { Address = "192.168.127.250/24"; }; }
      ];
    };
  };

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking.hostName = "r3-virt";
  networking.hostId = "8d4df7ab";

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;

  users.users = {
    root = {
      initialPassword = "test123";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";

  mkg.mod = {
    yggdrasil = {
      enable = true;
      port = 17858;
      peers = [ "tcp://ygg.mkg20001.io:80" "tls://ygg.mkg20001.io:443" ];
    };
  };

  networking.firewall.extraForwardRules = "accept";
  networking.firewall.logRefusedPackets = true;
  networking.nftables.tables."nat" = {
    family = "inet";
    content = ''
      chain post {
        type nat hook postrouting priority srcnat; policy accept;
        iifname "enp1s0" oifname "incusbr0" ip saddr 192.168.0.0/16 snat to 10.34.55.1 comment "from internal interfaces"
      }
    '';
  };
}
