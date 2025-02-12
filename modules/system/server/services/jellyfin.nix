{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = config.my-secrets.private.vars.domain;
in {
  imports = [../../private-vars.nix];

  config = lib.mkIf cfg.enable {
    custom-modules.private-vars.enable = true;

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
