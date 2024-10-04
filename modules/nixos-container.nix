{ lib, ... }: {
  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  networking.useHostResolvConf = lib.mkForce false;

  boot.initrd.systemd.enable = lib.mkForce false;
  networking.useNetworkd = lib.mkForce false;
  nix.gc.automatic = lib.mkForce false;

  services.resolved.enable = true;
}
