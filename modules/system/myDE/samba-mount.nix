{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myDE;
in
{
  config = lib.mkIf cfg.enable {
    sops.secrets.ecobox-smb_bas-creds = { };

    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems =
      let
        genericSambaSettings = {
          fsType = "cifs";
          options = [
            "credentials=${config.sops.secrets.ecobox-smb_bas-creds.path}"
            "x-systemd.automount"
            "nofail"
            "uid=bas"
            "gid=users"
          ];
        };
      in
      {
        "/mnt/ecobox/general" = genericSambaSettings // {
          device = "//${config.my-secrets.private.vars.smb-ip}/general";
        };
        "/mnt/ecobox/video" = genericSambaSettings // {
          device = "//${config.my-secrets.private.vars.smb-ip}/video";
        };
        "/mnt/ecobox/photo" = genericSambaSettings // {
          device = "//${config.my-secrets.private.vars.smb-ip}/photo";
        };
      };
  };
}
