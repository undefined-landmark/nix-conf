{
  inputs,
  config,
  pkgs,
  ...
}: let
  semi-secrets = import "${inputs.secrets}/semi-secret.nix";
in {
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
      "gid=bas"
    ];
  };
}
