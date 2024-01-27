{ config, lib, ... }:

with lib;

{
  nixpkgs.hostPlatform = mkIf (config.system.build ? vm) (mkForce "x86_64-linux");
  networking.useDHCP = mkIf (config.system.build ? vm) (mkForce true);
}
