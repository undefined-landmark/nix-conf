{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.restic;
in {
  imports = [
    ./sops.nix
    ./private-vars.nix
  ];

  options.custom-modules.restic = {
    enable = lib.mkEnableOption "Restic backup service";
  };

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;
    sops.secrets.restic-east_env = {};
    sops.secrets.restic-east_repo = {};
    sops.secrets.restic-east_pass = {};

    custom-modules.private-vars.enable = true;

    services.restic.backups = {
      east = {
        createWrapper = true;
        inhibitsSleep = true;
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
