{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.grafana;
  grafanaPort = config.services.grafana.settings.server.http_port;
in
{
  options.myServices.grafana.enable = lib.mkEnableOption "Setup grafana";

  config = lib.mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings.server.http_port = 3333;
    };

    myServices.traefik.params = [
      {
        subdomain = "grafana";
        port = toString grafanaPort;
      }
    ];
  };
}
