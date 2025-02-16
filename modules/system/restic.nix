{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.restic;
  user = config.users.users.bas.name;
  secret-settings = {
    mode = "0440";
    owner = config.users.users.bas.name;
    group = config.users.users.bas.group;
  };
in {
  options.custom-modules.restic = {
    enable = lib.mkEnableOption "Restic backup service";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.restic-east_env = secret-settings;
    sops.secrets.restic-east_repo = secret-settings;
    sops.secrets.restic-east_pass = secret-settings;

    services.restic.backups = {
      east = {
        createWrapper = true;
        inhibitsSleep = true;
        user = user;
        repositoryFile = config.sops.secrets.restic-east_repo.path;
        passwordFile = config.sops.secrets.restic-east_pass.path;
        environmentFile = config.sops.secrets.restic-east_env.path;

        paths = config.my-secrets.private.vars.restic-east_paths;
        # timerConfig = {
        #   OnCalendar = "daily";
        #   Persistent = true;
        # };

        runCheck = true;
        checkOpts = ["--with-cache" "--read-data-subset=1G"];
      };
    };
  };
}
