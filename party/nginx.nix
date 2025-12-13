{ config, pkgs, lib, ... }:

with lib;

let
  h = a: a // {
    enableACME = true;
    forceSSL = true;
  };
in
{
  security.acme.defaults.dnsProvider = "acme-dns";
  security.acme.defaults.email = "mkg20001@gmail.com";
  security.acme.defaults.environmentFile = pkgs.writeText "acme-env" ''
    ACME_DNS_API_BASE=http://acme-dns.realraum.at
    ACME_DNS_STORAGE_PATH=/var/lib/acme/dns.json
  '';
  security.acme.acceptTerms = true;
  
  security.acme.certs."jellyfin.realraum.at".webroot = mkForce null;
  security.acme.certs."jellyfin.realraum.at".dnsProvider = "acme-dns";

  services.nginx.enable = true;

  services.nginx.enableReload = true;
  services.nginx.recommendedBrotliSettings = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.recommendedTlsSettings = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.virtualHosts = {
    "jellyfin.realraum.at" = h {
      locations."/" = {
        proxyPass = "http://localhost:8096/";
      };
    };
  };
}
