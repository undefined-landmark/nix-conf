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
