{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      ../modules/common.nix
      ../modules/container.nix
    ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "r3-acme"; # Define your hostname.

  networking.interfaces.eth0.useDHCP = mkForce false;
  systemd.network = {
    enable = true;
    networks."40-eth0" = {
      matchConfig = {
        Name = "eth0";
      };
      gateway = [ "192.168.127.254" "2a02:3e0:4000:1::1" ];
      networkConfig = {
      };
      addresses = [
        { addressConfig = { Address = "89.106.211.59/27"; }; }
        { addressConfig = { Address = "2a02:3e0:4000:1::59/64"; }; }
      ];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 ];
    extraInputRules = ''
      ip saddr { 192.168.0.0/16, 10.0.0.0/8 } tcp dport 80 accept
      ip6 saddr 2a02:3e0:4000:1::/64 tcp dport 80 accept
    '';
  };

  services.acme-dns = {
    enable = true;
    settings.general.records = [
      "acme-dns.realraum.at. A 89.106.211.59"
      "acme-dns.realraum.at. AAAA 2a02:3e0:4000:1::59"
      "acme-dns.realraum.at. NS acme-dns.realraum.at."
    ];

    settings.general.nsname = "acme-dns.realraum.at";
    settings.general.nsadmin = "admin.realraum.at";
    settings.general.domain = "acme-dns.realraum.at";
    # settings.database.engine
    # settings.database.connection
    settings.api.port = 80;
    # settings.api.disable_registration
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  system.stateVersion = "24.05";

  mkg.mod = {
    yggdrasil = {
      enable = true;
      port = 17858;
      peers = [ "tcp://ygg.mkg20001.io:80" "tls://ygg.mkg20001.io:443" ];
    };
  };
}
