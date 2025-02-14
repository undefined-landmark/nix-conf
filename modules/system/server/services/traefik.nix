{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
  personalEmail = config.my-secrets.private.vars.email;
  baseDomain = cfg.baseDomain;
  traefikAdd = import ./traefikAdd.nix;
in {
  imports = [../../sops.nix];

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;

    sops.secrets.traefik_env = {
      mode = "0440";
      owner = "traefik";
      group = config.services.traefik.group;
    };

    services.traefik = {
      enable = true;
      environmentFiles = [config.sops.secrets.traefik_env.path];
      staticConfigOptions = {
        api.insecure = true;
        log.level = "debug";

        # Certificate
        certificatesResolvers = {
          letsenc.acme = {
            email = personalEmail;
            storage = "/var/lib/traefik/acme.json";
            caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "desec";
              #              resolvers = ["1.1.1.1:53" "9.9.9.9:53"];
              #              delayBeforeCheck = 60;
              #              disablePropagationCheck = true;
            };
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
                  sans = ["*.${baseDomain}"];
                }
              ];
            };
          };
        };
      };
    };

    services.traefik.dynamicConfigOptions = traefikAdd {
      domain = baseDomain;
      subdomain = "traefik";
      port = "8080";
    };
    networking.firewall.allowedTCPPorts = [80 443];
  };
}
