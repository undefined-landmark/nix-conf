{
  lib,
  config,
  ...
}:
let
  cfg = config.mySys.restic;
  sopsCfg = config.sops.secrets;

  resticSecrets = {
    lightbox = {
      lightbox_restic-west_repo = { };
      lightbox_restic-west_pass = { };
      lightbox_restic-west_env = { };
    };
    ecobox = {
      restic-east_env = { };
      restic-east_repo = { };
      restic-east_pass = { };
      restic-local_repo = { };
      restic-local_pass = { };
    };
  };

  resticBackups =
    let
      universalSettings = {
        createWrapper = true;
        inhibitsSleep = true;
        runCheck = true;
        checkOpts = [
          "--with-cache"
          "--read-data-subset=1G"
        ];
      };

      dailyTimer = {
        OnCalendar = "daily";
        Persistent = true;
      };
    in
    {
      lightbox = {
        west = universalSettings // {
          repositoryFile = sopsCfg.lightbox_restic-west_repo.path;
          passwordFile = sopsCfg.lightbox_restic-west_pass.path;
          environmentFile = sopsCfg.lightbox_restic-west_env.path;
          paths = config.my-secrets.private.vars.restic-lightbox_paths;
          timerConfig = dailyTimer;
        };
      };
      ecobox =
        let
          pathSettings = {
            paths = config.my-secrets.private.vars.restic-ecobox_paths;
            exclude = config.my-secrets.private.vars.restic-ecobox_exclude;
          };
        in
        {
          east =
            universalSettings
            // pathSettings
            // {
              repositoryFile = sopsCfg.restic-east_repo.path;
              passwordFile = sopsCfg.restic-east_pass.path;
              environmentFile = sopsCfg.restic-east_env.path;
              timerConfig = dailyTimer // {
                RandomizedDelaySec = "5h";
              };
            };
          local =
            universalSettings
            // pathSettings
            // {
              repositoryFile = sopsCfg.restic-local_repo.path;
              passwordFile = sopsCfg.restic-local_pass.path;
              timerConfig = null;
            };
        };
    };
in
{
  options.mySys.restic = {
    enable = lib.mkEnableOption "Restic backup service";
    hostname = lib.mkOption {
      type = lib.types.str;
      description = ''
        Hostname of the machine where the backup will be made.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = lib.getAttr cfg.hostname resticSecrets;
    services.restic.backups = lib.getAttr cfg.hostname resticBackups;
  };
}
