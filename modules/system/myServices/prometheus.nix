{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.myServices.prometheus;
  nodePort = config.services.prometheus.exporters.node.port;
  zfsPort = config.services.prometheus.exporters.zfs.port;
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
    sops.secrets.qbit_password = { };

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
        zfs = {
          enable = true;
          extraFlags = [
            "--no-collector.dataset-filesystem"
            "--no-collector.dataset-volume"
            "--properties.pool=\"health\""
            "--web.disable-exporter-metrics"
          ];
        };
        qbittorrent = {
          enable = true;
          url = "http://localhost:${qbitPort}";
          username = config.my-secrets.private.vars.qbitUser;
          passwordFile = config.sops.secrets.qbit_password.path;
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
          job_name = "zfs_exporter";
          static_configs = [
            {
              targets = [ "localhost:${toString zfsPort}" ];
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
