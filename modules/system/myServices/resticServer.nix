{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
in {
  config = lib.mkIf cfg.enable {
    services.restic.server = {
      enable = true;
      privateRepos = true;
      appendOnly = true;
      dataDir = "/zbig/main/restic-server";
    };

    myServices.traefikDynamic = [
      {
        subdomain = "restic-west";
        port = "8000";
      }
    ];
  };
}
