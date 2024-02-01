{ config, pkgs, lib, ... }:

with lib;

{
    boot.kernel.sysctl = {
      # fix too many files open
      "fs.file-max" = "20480000";
      "fs.inotify.max_user_watches" = "20480000";
      "fs.inotify.max_user_instances" = "20480000";
      "fs.inotify.max_queued_events" = "20480000";
      # allow IPv6 addrs to directly go out
      "net.ipv6.conf.all.proxy_ndp" = "1";
      # swap improvments
      "vm.swappiness" = 80;
      # fix docker
      "kernel.keys.root_maxkeys" = 1000000;
      "kernel.keys.maxkeys" = 1000000;
      # forwarding
      "net.ipv6.conf.all.forwarding" = 1;
      "net.ipv4.conf.all.forwarding" = 1;
    };

    networking.firewall = {
      extraForwardRules = ''
        iifname { "incusbr0", "incusbr1", "enp1s0" } oifname { "incusbr0", "incusbr1", "enp1s0" } accept
      '';
      trustedInterfaces = [ "incusbr0" "incusbr1" ];
    };

    systemd.services.incus = {
      restartIfChanged = false; # do it later
      requires = mkForce ["network-online.target" "incus.socket"];
    };

    boot.kernelModules = ["vhost_vsock"]; # for vms

    environment.systemPackages = with pkgs; [
      tcpdump
      socat
      mtr

      # edac-util -rfull => ecc errors
      edac-utils
    ];

    networking.firewall.allowedTCPPorts = [ 8443 ];
}
