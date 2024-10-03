{ config, pkgs, lib, ... }:

let
  SSL = {
    enableACME = false;
    #enableACME = true;
    forceSSL = false;
    #forceSSL = true;
  };
in
{
  networking.firewall.allowedTCPPorts = [
    80 
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = null;
    #defaults.email = "domain-admin@realraum.at";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "realraum.at" = SSL // {
        locations."/".proxyPass = "http://192.168.100.11:80/";

        serverAliases = [
          "www.realraum.at"
        ];
      };

      "wiki.realraum.at" = SSL // {
        locations."/".proxyPass = "http://192.168.100.11:80";
      };
    };
  };
}
