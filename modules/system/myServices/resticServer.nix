{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.resticServer;
in {
  options.myServices.resticServer.enable = lib.mkEnableOption "Setup resticServer";

  config = lib.mkIf cfg.enable {
    services.restic.server = {
      enable = true;
      privateRepos = true;
      appendOnly = true;
      dataDir = "/zbig/main/restic-server";
    };

    myServices.traefik.params = [
      {
        subdomain = "restic-west";
        port = "8000";
      }
    ];
  };
}
