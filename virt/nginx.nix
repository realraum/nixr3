{ config, pkgs, lib, ... }:

with lib;

{
  security.acme.defaults.dnsProvider = "acme-dns";
  security.acme.defaults.email = "mkg20001@gmail.com";
  security.acme.defaults.environmentFile = pkgs.writeText "acme-env" ''
    ACME_DNS_API_BASE=http://acme-dns.realraum.at
    ACME_DNS_STORAGE_PATH=/var/lib/acme/dns.json
  '';
  security.acme.acceptTerms = true;
  
  security.acme.certs."parts.realraum.at".webroot = mkForce null;
  security.acme.certs."parts.realraum.at".dnsProvider = "acme-dns";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    enableReload = true;

    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "parts.realraum.at" = {
         enableACME = true;
         forceSSL = true;
         locations."/".proxyPass = "http://10.34.55.51";
      };

      "cfp.realraum.at" = {
         enableACME = true;
         forceSSL = true;
         locations."/".proxyPass = "http://10.34.55.69";
      };
    };
  };
}
