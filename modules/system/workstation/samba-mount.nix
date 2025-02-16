{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.ecobox-smb-creds = {};

    environment.systemPackages = [pkgs.cifs-utils];

    fileSystems."/mnt/ecobox-smb" = {
      device = "//${config.my-secrets.private.vars.smb-ip}/alles";
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
