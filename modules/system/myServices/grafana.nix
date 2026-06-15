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
    sops.secrets.grafana_secret-key = {
      owner = "grafana";
    };

    services.grafana = {
      enable = true;
      settings = {
        server.http_port = 3333;
        security.secret_key = "$__file{${config.sops.secrets.grafana_secret-key.path}}";
      };
    };

    myServices.traefik.params = [
      {
        subdomain = "grafana";
        port = toString grafanaPort;
      }
    ];
  };
}
