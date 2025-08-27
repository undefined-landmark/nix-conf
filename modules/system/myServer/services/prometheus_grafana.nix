{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
  grafanaPort = config.services.grafana.settings.server.http_port;
  prometheusPort = config.services.prometheus.port;
  nodePort = config.services.prometheus.exporters.node.port;
in {
  config = lib.mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings.server.http_port = 3333;
      provision.datasources.settings.datasources = [
      {
        name = "Prometheus";
        type = "prometheus";
        url = "http://localhost:${toString prometheusPort}";
      }
    ];
    };

    services.prometheus = {
      enable = true;

      exporters.node = {
        enable = true;
        enabledCollectors = ["systemd"];
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

    myServer.traefikDynamic = [
      {
        subdomain = "grafana";
        port = toString grafanaPort;
      }
    ];
  };
}
