{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.resticServer;
in {
  options.myServices.resticServer = {
    enable = lib.mkEnableOption "Setup resticServer";
    dataDir = lib.mkOption {
      type = lib.types.str;
      description = "dataDir for restic.server";
    };
    subdomain = lib.mkOption {
      type = lib.types.str;
      description = "Subdomain that should be used";
    };
  };

  config = lib.mkIf cfg.enable {
    services.restic.server = {
      enable = true;
      privateRepos = true;
      appendOnly = true;
      inherit (cfg) dataDir;
    };

    myServices.traefik.params = [
      {
        inherit (cfg) subdomain;
        port = config.services.restic.server.listenAddress;
      }
    ];
  };
}
