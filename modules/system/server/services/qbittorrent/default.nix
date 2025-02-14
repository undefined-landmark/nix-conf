{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = config.my-secrets.private.vars.domain;
  portScript = builtins.readFile ./port-checker.sh;
  creds_path = config.sops.secrets.qbittorrent_post_creds.path;
  portApp = pkgs.writeShellApplication {
    name = "qbit-natpmp-port";
    runtimeInputs = [pkgs.curl pkgs.libnatpmp];
    text = builtins.replaceStrings ["./creds_path"] [creds_path] portScript;
  };
in {
  imports = [
    "${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"
    ../../../sops.nix
  ];

  config = lib.mkIf cfg.enable {
    custom-modules.private-vars.enable = true;
    custom-modules.sops.enable = true;
    sops.secrets.qbittorrent_post_creds = {
      mode = "0440";
      owner = config.services.qbittorrent.user;
      group = config.services.qbittorrent.group;
    };

    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = cfg.mediagroup;
      openFirewall = true;
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

    systemd.services.qbitPortCheck = {
      description = "Checks NAT-PMP port and sets the port for qBittorrent";
      after = [
        "network.target"
        "qbittorrent.service"
        "wg-quick-protonfw.service"
      ];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = config.services.qbittorrent.user;
        Group = config.services.qbittorrent.group;
        DynamicUser = true;
        ExecStart = lib.getExe portApp;
        Restart = "on-failure";
      };
    };
  };
}
