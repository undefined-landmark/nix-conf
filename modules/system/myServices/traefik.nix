{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.traefik;
  personalEmail = config.my-secrets.private.vars.email;
  baseDomain = config.myServices.baseDomain;
in
{
  options.myServices.traefik.enable = lib.mkEnableOption "Traefik setup";

  config = lib.mkIf cfg.enable {
    sops.secrets.traefik_env = {
      mode = "0440";
      owner = "traefik";
      group = config.services.traefik.group;
    };

    services.traefik = {
      enable = true;
      environmentFiles = [ config.sops.secrets.traefik_env.path ];
      staticConfigOptions = {
        api.insecure = true;
        # log.level = "debug";

        # Certificate
        certificatesResolvers = {
          letsenc.acme = {
            email = personalEmail;
            storage = "${config.services.traefik.dataDir}/acme.json";
            # caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
            dnsChallenge.provider = "mijnhost";
          };
        };

        entrypoints = {
          # HTTP > HTTPS redirect
          web = {
            address = ":80";
            http.redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
            };
          };

          # HTTPS
          websecure = {
            address = ":443";
            http.tls = {
              certResolver = "letsenc";
              domains = [
                {
                  main = baseDomain;
                  sans = [ "*.${baseDomain}" ];
                }
              ];
            };
          };
        };
      };
    };

    myServices.traefik.params = [
      {
        subdomain = "traefik";
        port = "8080";
      }
    ];

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
