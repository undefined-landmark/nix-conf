{
  lib,
  config,
  inputs,
  pkgsPromQbit,
  ...
}:
let
  cfg = config.myServices.prometheus;
  nodePort = config.services.prometheus.exporters.node.port;
  qbitPort = toString config.services.qbittorrent.webuiPort;
  qbitExpPort = config.services.prometheus.exporters.qbittorrent.port;
in
{
  disabledModules = [ "services/monitoring/prometheus/exporters.nix" ];

  imports = [ 
    "${inputs.prom-qbit}/nixos/modules/services/monitoring/prometheus/exporters.nix" 
  ];

  options.myServices.prometheus.enable = lib.mkEnableOption "Setup prometheus";

  config = lib.mkIf cfg.enable {
    sops.secrets.prometheus_qbit_env = {
      owner = config.services.prometheus.exporters.qbittorrent.user;
      group = config.services.prometheus.exporters.qbittorrent.group;
    };

    services.prometheus = {
      enable = true;

      exporters = {
        node = {
          enable = true;
          extraFlags = [ "--collector.disable-defaults" ];
          enabledCollectors = [
            "systemd"
            "cpu"
            "meminfo"
            "hwmon"
            "filesystem"
          ];
        };
        qbittorrent = {
          enable = true;
          package = pkgsPromQbit.prometheus-qbittorrent-exporter;
          url = "http://localhost:${qbitPort}";
          username = config.my-secrets.private.vars.qbitUser;
          environmentFile = config.sops.secrets.prometheus_qbit_env.path;
        };
      };

      scrapeConfigs = [
        {
          job_name = "node_exporter";
          static_configs = [
            {
              targets = [ "localhost:${toString nodePort}" ];
            }
          ];
        }
        {
          job_name = "qbittorrent_exporter";
          static_configs = [
            {
              targets = [ "localhost:${toString qbitExpPort}" ];
            }
          ];
        }
      ];
    };
  };
}
