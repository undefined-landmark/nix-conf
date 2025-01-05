{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.custom-modules.samba-mount;
in {
  imports = [
    ./sops.nix
    ./private-vars.nix
  ];

  options.custom-modules.samba-mount = {
    enable = lib.mkEnableOption "Samba Mount";
  };

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;
    sops.secrets.ecobox-smb-creds = {};

    custom-modules.private-vars.enable = true;

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
