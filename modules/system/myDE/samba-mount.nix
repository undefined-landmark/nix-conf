{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myDE;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.ecobox-smb-creds = {};

    environment.systemPackages = [pkgs.cifs-utils];

    fileSystems."/mnt/ecoshare" = {
      device = "//${config.my-secrets.private.vars.smb-ip}/ecoshare";
      fsType = "cifs";
      options = [
        "credentials=${config.sops.secrets.ecobox-smb-creds.path}"
        "x-systemd.automount"
        "nofail"
        "uid=bas"
        "gid=users"
      ];
    };
  };
}
