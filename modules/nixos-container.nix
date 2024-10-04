{ lib, ... }: {
  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  networking.useHostResolvConf = lib.mkForce false;

  services.resolved.enable = true;
}
