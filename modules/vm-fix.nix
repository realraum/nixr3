{ config, lib, ... }:

with lib;

{
  nixpkgs.hostPlatform = mkIf (config.virtualisation ? fileSystems) (mkForce "x86_64-linux");
  networking.useDHCP = mkIf (config.virtualisation ? fileSystems) (mkForce true);
}
