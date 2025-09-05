{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.jellyfin;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = config.myServices.mediagroup;
    };

    myServices.traefik.params = [
      {
        subdomain = "jellyfin";
        port = "8096";
      }
    ];
  };
}
