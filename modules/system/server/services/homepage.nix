{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.server;
  homepagePort = toString config.services.homepage-dashboard.listenPort;
  baseDomain = cfg.baseDomain;
in {
  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = baseDomain;
      widgets = [
        {
          resources = {
            cpu = true;
            cputemp = true;
            units = "metric";
            memory = true;
            uptime = true;
          };
        }
        {
          resources = {
            label = "Storage";
            expanded = true;
            disk = [
              "/zbig/main"
              "/"
            ];
          };
        }
      ];
      services = [
        {
          "Local Services" = [
            {
              Jellyfin = {
                icon = "jellyfin";
                href = "https://jellyfin.${baseDomain}";
                description = "Movies and Series";
              };
            }
            {
              qBittorrent = {
                icon = "qbittorrent";
                href = "https://qbittorrent.${baseDomain}";
                description = "Torrents";
              };
            }
            {
              Tandoor = {
                icon = "tandoor-recipes";
                href = "https://tandoor.${baseDomain}";
                description = "Recipe manager";
              };
            }
            {
              Paperless = {
                icon = "paperless";
                href = "https://paperless.${baseDomain}";
                description = "(Scanned) document management";
              };
            }
          ];
        }
        {
          Administration = [
            {
              Traefik = {
                icon = "traefik";
                href = "https://traefik.${baseDomain}";
                description = "Reverse proxy";
              };
            }
          ];
        }
      ];
    };

    services.traefik.dynamicConfigOptions.http = {
      routers = {
        "homepage" = {
          service = "homepage";
          rule = "Host(`${cfg.baseDomain}`)";
        };
      };
      services = {
        "homepage".loadBalancer.servers = [
          {url = "http://localhost:${homepagePort}";}
        ];
      };
    };
  };
}
