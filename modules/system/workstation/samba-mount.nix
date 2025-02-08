{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  imports = [
    ../sops.nix
    ../private-vars.nix
  ];

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
