{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    services.restic.server = {
      enable = true;
      privateRepos = true;
      appendOnly = true;
      dataDir = "/zbig/main/restic-server";
    };

    myServer.traefikDynamic = [
      {
        subdomain = "restic-west";
        port = "8000";
      }
    ];
  };
}
