{ config, pkgs, lib, modulesPath, inputs, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      ../modules/common.nix
      inputs.mgit-common.nixosModules.hcloud_base
    ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "r3-mailcow"; # Define your hostname.

  mgit.hcloud.auto-network = "2a01:4f8:c013:6665::2/64";

  services.mailcow = {
    enable = true;
    settings = {
      SKIP_CLAMD = "y";
      SKIP_SOGO = "y";
      SKIP_SOLR = "y";
    };
  };

  services.docuum.enable = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  system.stateVersion = "25.11";

  mkg.mod = {
    yggdrasil = {
      enable = true;
      port = 17858;
      peers = [ "tcp://ygg.mkg20001.io:80" "tls://ygg.mkg20001.io:443" ];
    };
  };
}
