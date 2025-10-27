{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.arr;
  mediagroup = config.myServices.mediagroup;
in
{
  options.myServices.arr.enable = lib.mkEnableOption "Arr setup";

  config = lib.mkIf cfg.enable {
    sops.secrets.radarr-api_key = { };
    sops.secrets.sonarr-api_key = { };

    systemd.services.recyclarr.serviceConfig.LoadCredential = [
      "radarr-api_key:${config.sops.secrets.radarr-api_key.path}"
      "sonarr-api_key:${config.sops.secrets.sonarr-api_key.path}"
    ];

    services = {
      prowlarr.enable = true;
      sonarr = {
        enable = true;
        group = mediagroup;
      };
      radarr = {
        enable = true;
        group = mediagroup;
      };
      recyclarr = {
        enable = true;
        configuration = {
          radarr = config.my-secrets.private.vars.radarrConfig;
          sonarr = config.my-secrets.private.vars.sonarrConfig;
        };
      };
    };

    myServices.traefik.params =
      builtins.map
        (name: {
          subdomain = "${name}";
          port = toString config.services."${name}".settings.server.port;
        })
        [
          "prowlarr"
          "sonarr"
          "radarr"
        ];
  };
}
