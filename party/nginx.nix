{ config, pkgs, lib, ... }:

with lib;

let
  h = a: a // {
    enableACME = true;
    forceSSL = true;
  };
in
{
  services.nginx.enable = true;

  services.nginx.enableReload = true;
  services.nginx.recommendedBrotliSettings = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.recommendedTlsSettings = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

#  services.nginx.virtualHosts = {
#    "" = h {
#      locations."/" = {
#        proxyPass = "http://localhost:8080/";
#      };
#    };
#  };
}
