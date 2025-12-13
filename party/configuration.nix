{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      ../modules/common.nix
      ../modules/container.nix
      ./jellyfin.nix
    ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "r3-party"; # Define your hostname.

  networking.firewall = {
    allowedUDPPorts = [ 443 ];
    allowedTCPPorts = [ 80 443 ];
  };

  system.stateVersion = "26.05";

  mkg.mod = {
    yggdrasil = {
      enable = true;
      port = 17858;
      peers = [ "tcp://ygg.mkg20001.io:80" "tls://ygg.mkg20001.io:443" ];
    };
  };

  fileSystems."/nas" = {
    device = "192.168.69.15:/";
    fsType = "nfs";
  };
  # optional, but ensures rpc-statsd is running for on demand mounting
  boot.supportedFilesystems = [ "nfs" ];


}
