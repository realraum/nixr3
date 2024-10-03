{ modulesPath, lib, ... }: with lib; {
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];

  boot.isContainer = true;

  # networkd
  networking.useNetworkd = mkForce true;
  networking.dhcpcd.enable = mkForce false;
  services.resolved.dnssec = "false";
  systemd.network.wait-online.enable = false;
  networking.useHostResolvConf = mkForce false;

  # don't do dhcp everywhere
  networking.useDHCP = mkForce false;
  # just on eth0
  networking.interfaces.eth0.useDHCP = true;
}
