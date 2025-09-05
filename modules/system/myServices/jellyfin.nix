{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = cfg.mediagroup;
    };

    myServices.traefikDynamic = [
      {
        subdomain = "jellyfin";
        port = "8096";
      }
    ];
  };
}
