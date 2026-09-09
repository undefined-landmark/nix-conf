{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.homepage;
  homepagePort = toString config.services.homepage-dashboard.listenPort;
  baseDomain = config.myServices.baseDomain;
in
{
  options.myServices.homepage.enable = lib.mkEnableOption "Setup homepage";

  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = baseDomain;
      services = [
        {
          Services = [
            {
              Seerr = {
                icon = "seerr";
                href = "https://seerr.${baseDomain}";
                description = "Request Movies and Series";
              };
            }
            {
              Calibre = {
                icon = "calibre";
                href = "https://calibre.${baseDomain}";
                description = "eBook organizer";
              };
            }
            {
              Jellyfin = {
                icon = "jellyfin";
                href = "https://jellyfin.${baseDomain}";
                description = "Movies and Series";
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
            {
              Grafana = {
                icon = "grafana";
                href = "https://grafana.${baseDomain}";
                description = "System info dashboard";
              };
            }
            {
              qui = {
                icon = "qui";
                href = "https://qui.${baseDomain}";
                description = "Torrents";
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
          rule = "Host(`${baseDomain}`)";
        };
      };
      services = {
        "homepage".loadBalancer.servers = [
          { url = "http://localhost:${homepagePort}"; }
        ];
      };
    };
  };
}
