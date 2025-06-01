{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.server;
in {
  config = lib.mkIf cfg.enable {
    services.restic.server = {
      enable = true;
      privateRepos = true;
      appendOnly = true;
      dataDir = "/zbig/main/restic-server";
    };

    mySys.server.traefikDynamic = [
      {
        subdomain = "restic-west";
        port = "8000";
      }
    ];
  };
}
