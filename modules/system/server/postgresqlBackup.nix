{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  config = lib.mkIf cfg.enable {
    services.postgresqlBackup = {
      enable = true;
      database = config.services.postgresql.ensureDatabases;
    };
  };
}
