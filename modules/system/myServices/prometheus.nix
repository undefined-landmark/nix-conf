{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.prometheus;
  nodePort = config.services.prometheus.exporters.node.port;
in {
  options.myServices.prometheus.enable = lib.mkEnableOption "Setup prometheus";

  config = lib.mkIf cfg.enable {
    services.prometheus = {
      enable = true;

      exporters.node = {
        enable = true;
        extraFlags = ["--collector.disable-defaults"];
        enabledCollectors = ["systemd" "cpu" "meminfo" "hwmon" "filesystem"];
      };

      scrapeConfigs = [
        {
          job_name = "node_exporter";
          static_configs = [
            {
              targets = ["localhost:${toString nodePort}"];
            }
          ];
        }
      ];
    };
  };
}
