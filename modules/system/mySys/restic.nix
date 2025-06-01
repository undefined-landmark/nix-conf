{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.restic;
  sopsCfg = config.sops.secrets;
  basUser = config.users.users.bas.name;

  secret-settings.owner = basUser;
  resticSecrets = {
    bigbox = {
      restic-east_env = secret-settings;
      restic-east_repo = secret-settings;
      restic-east_pass = secret-settings;
      restic-local_repo = secret-settings;
      restic-local_pass = secret-settings;
    };
    lightbox = {
      lightbox_restic-west_repo = {};
      lightbox_restic-west_pass = {};
      lightbox_restic-west_env = {};
    };
    ecobox = {
      restic-east_env = {};
      restic-east_repo = {};
      restic-east_pass = {};
    };
  };

  universalSettings = {
    createWrapper = true;
    inhibitsSleep = true;
    runCheck = true;
    checkOpts = ["--with-cache" "--read-data-subset=1G"];
  };
  resticBackups = {
    bigbox = {
      east =
        universalSettings
        // {
          user = basUser;
          repositoryFile = sopsCfg.restic-east_repo.path;
          passwordFile = sopsCfg.restic-east_pass.path;
          environmentFile = sopsCfg.restic-east_env.path;
          paths = config.my-secrets.private.vars.restic-bigbox_paths;
          timerConfig = null;
          # timerConfig = {
          #   OnCalendar = "daily";
          #   Persistent = true;
          # };
        };
      local =
        universalSettings
        // {
          repositoryFile = sopsCfg.restic-local_repo.path;
          passwordFile = sopsCfg.restic-local_pass.path;
          paths = config.my-secrets.private.vars.restic-bigbox_paths;
          timerConfig = null;
        };
    };
    lightbox = {
      west =
        universalSettings
        // {
          repositoryFile = sopsCfg.lightbox_restic-west_repo.path;
          passwordFile = sopsCfg.lightbox_restic-west_pass.path;
          environmentFile = sopsCfg.lightbox_restic-west_env.path;
          paths = config.my-secrets.private.vars.restic-lightbox_paths;
          timerConfig = null;
        };
    };
    ecobox = {
      east =
        universalSettings
        // {
          repositoryFile = sopsCfg.restic-east_repo.path;
          passwordFile = sopsCfg.restic-east_pass.path;
          environmentFile = sopsCfg.restic-east_env.path;
          paths = config.my-secrets.private.vars.restic-ecobox_paths;
          timerConfig = null;
        };
    };
  };
in {
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
