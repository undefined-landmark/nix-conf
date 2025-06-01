{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = cfg.mediagroup;
    };

    myServer.traefikDynamic = [
      {
        subdomain = "jellyfin";
        port = "8096";
      }
    ];
  };
}
