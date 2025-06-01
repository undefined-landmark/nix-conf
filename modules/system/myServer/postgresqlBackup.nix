{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    services.postgresqlBackup = {
      enable = true;
      databases = config.services.postgresql.ensureDatabases;
    };
  };
}
