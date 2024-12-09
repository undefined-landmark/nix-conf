{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.custom-modules.samba-mount;
  semi-secrets = import "${inputs.secrets}/semi-secret.nix";
in {
  options.custom-modules.samba-mount = {
    enable = lib.mkEnableOption "Samba Mount";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.ecobox-smb-creds = {};

    environment.systemPackages = [pkgs.cifs-utils];

    fileSystems."/mnt/ecobox-smb" = {
      device = "//${semi-secrets.smb-ip}/alles";
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
