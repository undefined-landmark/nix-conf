{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = config.my-secrets.private.vars.domain;
in {
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];

  config = lib.mkIf cfg.enable {
    custom-modules.private-vars.enable = true;

    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = cfg.mediagroup;
    };

    services.traefik = {
      dynamicConfigOptions = {
        http = {
          routers = {
            qbittorrent.service = "qbittorrent";
            qbittorrent.rule = "Host(`qbittorrent.${baseDomain}`)";
          };
          services = {
            qbittorrent.loadBalancer.servers = [{url = "http://localhost:8888";}];
          };
        };
      };
    };
  };
}
