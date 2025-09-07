{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.grafana;
  grafanaPort = config.services.grafana.settings.server.http_port;
  prometheusPort = config.services.prometheus.port;
in {
  options.myServices.grafana.enable = lib.mkEnableOption "Setup grafana";

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

    myServices.traefik.params = [
      {
        subdomain = "grafana";
        port = toString grafanaPort;
      }
    ];
  };
}
