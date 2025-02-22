{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  imports = [./recyclarr.nix];

  config = lib.mkIf cfg.enable {
    services.prowlarr.enable = true;

    services.sonarr = {
      enable = true;
      group = cfg.mediagroup;
    };

    services.radarr = {
      enable = true;
      group = cfg.mediagroup;
    };

    custom-modules.server.traefikDynamic = [
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
  };
}
