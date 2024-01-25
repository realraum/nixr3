{
  modulesPath,
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  config = {
    system.build.qemuImage = import "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
      inherit pkgs lib config;

      partitionTableType = "efi";
      format = "qcow2-compressed";
      copyChannel = false;
      diskSize = "20000";
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/nixos";
        autoResize = true;
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-label/ESP";
        fsType = "vfat";
      };
    };

    boot.growPartition = true;
    boot.loader.systemd-boot.enable = true;
  };
}
