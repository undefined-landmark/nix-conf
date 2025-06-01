{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.server;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = cfg.mediagroup;
    };

    mySys.server.traefikDynamic = [
      {
        subdomain = "jellyfin";
        port = "8096";
      }
    ];
  };
}
