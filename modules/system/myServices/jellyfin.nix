{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.jellyfin;
in {
  options.myServices.jellyfin.enable = lib.mkEnableOption "Setup jellyfin";

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
