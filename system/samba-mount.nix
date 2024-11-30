{
  config,
  pkgs,
  ...
}: {
  sops.secrets.ecobox-smb = {};

  environment.systemPackages = [pkgs.cifs-utils];

  fileSystems."/mnt/ecobox-smb" = {
    device = "//<IP-OR-HOSTNAME?>/alles";
    fsType = "cifs";
    options = [
      "credentials=${config.sops.secrets.ecobox-smb.path}"
      "x-systemd.automount"
      "nofail"
      "uid=bas"
      "gid=bas"
    ];
  };
}
