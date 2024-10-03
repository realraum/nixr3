{
  containers.dokuwiki = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    bindMounts = {
      "/var/lib/dokuwiki" = {
        hostPath = "/var/lib/dokuwiki/";
        isReadOnly = false;
      };
    };

    config = ./dokuwiki;
  };
}
