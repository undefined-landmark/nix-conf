{
  lib,
  config,
  ...
}:
let
  cfg = config.myServer.postgresqlBackup;
in
{
  options.myServer.postgresqlBackup.enable = lib.mkEnableOption "Setup postgresqlBackup";

  config = lib.mkIf cfg.enable {
    services.postgresqlBackup = {
      enable = true;
      databases = config.services.postgresql.ensureDatabases;
    };
  };
}
