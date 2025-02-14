{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = cfg.baseDomain;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = cfg.mediagroup;
    };

    services.traefik = {
      dynamicConfigOptions = {
        http = {
          routers = {
            jellyfin.service = "jellyfin";
            jellyfin.rule = "Host(`jellyfin.${baseDomain}`)";
          };
          services = {
            jellyfin.loadBalancer.servers = [{url = "http://localhost:8096";}];
          };
        };
      };
    };
  };
}
