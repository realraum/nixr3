{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports =
    [ # Include the results of the hardware scan.
      ../modules/common.nix
      ../modules/container.nix
    ];

  services.grical-to-mob.enable = true;

  networking.hostName = "r3-misc"; # Define your hostname.
  boot.initrd.systemd.enable = mkForce false;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

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
