{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.prometheus;
  nodePort = config.services.prometheus.exporters.node.port;
  zfsPort = config.services.prometheus.exporters.zfs.port;
in
{
  options.myServices.prometheus.enable = lib.mkEnableOption "Setup prometheus";

  config = lib.mkIf cfg.enable {
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
      ];
    };
  };
}
