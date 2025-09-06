{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.arr;
  mediagroup = config.myServices.mediagroup;
in {
  options.myServices.arr.enable = lib.mkEnableOption "Arr setup";

  config = lib.mkIf cfg.enable {
    sops.secrets.radarr-api_key = {};
    sops.secrets.sonarr-api_key = {};

    services.prowlarr.enable = true;

    services.sonarr = {
      enable = true;
      group = mediagroup;
    };

    services.radarr = {
      enable = true;
      group = mediagroup;
    };

    myServices.traefik.params = [
      {
        subdomain = "prowlarr";
        port = "9696";
      }
      {
        subdomain = "sonarr";
        port = "8989";
      }
      {
        subdomain = "radarr";
        port = "7878";
      }
    ];

    systemd.services.recyclarr.serviceConfig.LoadCredential = [
      "radarr-api_key:${config.sops.secrets.radarr-api_key.path}"
      "sonarr-api_key:${config.sops.secrets.sonarr-api_key.path}"
    ];

    services.recyclarr = {
      enable = true;
      configuration = {
        radarr = config.my-secrets.private.vars.radarrConfig;
        sonarr = config.my-secrets.private.vars.sonarrConfig;
      };
    };
  };
}
