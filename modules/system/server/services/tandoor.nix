{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = cfg.baseDomain;
  tandoorPort = 8222;
  tandoorNginxPort = 8555;
  mediaDir = "/var/lib/tandoor-recipes/";
  # For temporary binding mediaDir
  runDir = "/run/tandoor-recipes/";
in {
  config = lib.mkIf cfg.enable {
    services.tandoor-recipes = {
      enable = true;
      port = tandoorPort;
      extraConfig = {
        TIMEZONE = "Europe/Amsterdam";
        DB_ENGINE = "django.db.backends.postgresql";
        POSTGRES_HOST = "/run/postgresql";
        POSTGRES_USER = "tandoor_recipes";
        POSTGRES_DB = "tandoor_recipes";
        SECRET_KEY = config.my-secrets.private.vars.tandoorSecret;
        ALLOWED_HOSTS = "tandoor.${baseDomain}";
      };
    };

    systemd.services = {
      tandoor-recipes = {
        after = ["postgresql.service"];
        before = ["nginx.service"];
        requires = ["postgresql.service" "nginx.service"];
      };
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = ["tandoor_recipes"];
      ensureUsers = [
        {
          name = "tandoor_recipes";
          ensureDBOwnership = true;
        }
      ];
    };

    # Host media directory and forward via nginx
    # Create bindpath so the service can access mediaDir
    # TODO: Maybe set group in tandoor service instead?
    systemd.services.nginx.serviceConfig.BindPaths = ["${mediaDir}:${runDir}"];

    services.nginx = {
      enable = true;
      enableReload = true;
      preStart = "mkdir -p ${runDir}";
      virtualHosts."tandoor" = {
        listen = [
          {
            addr = "127.0.0.1";
            port = tandoorNginxPort;
          }
        ];
        locations = {
          "/media/".alias = "${runDir}";
          "/" = {
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Proto https;
            '';
            proxyPass = "http://127.0.0.1:${toString tandoorPort}";
          };
        };
      };
    };

    # Forward traefik to nginx
    custom-modules.server.traefikDynamic = [
      {
        subdomain = "tandoor";
        port = toString tandoorNginxPort;
      }
    ];
  };
}
