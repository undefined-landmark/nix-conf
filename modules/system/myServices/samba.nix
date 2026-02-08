{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.samba;
in
{
  options.myServices.samba.enable = lib.mkEnableOption "Samba setup";

  config = lib.mkIf cfg.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings =
        let
          genericShareSettings = {
            "valid users" = "bas";
            browseable = "no";
            writable = "yes";
            "create mask" = "0644";
            "directory mask" = "0755";
          };
        in
        {
          global = {
            security = "user";
            "server string" = "ecoboxsamba";
            "hosts allow" = [
              "192.168.2."
              "172.17.0."
            ];
          };

          # Share settings
          nvme = genericShareSettings // {
            comment = "nvme share";
            path = "/mnt/smb/alles";
          };

          torrent = genericShareSettings // {
            comment = "nvme share";
            path = "/mnt/medialab/torrent";
          };

          home = genericShareSettings // {
            comment = "home share";
            path = "/zbig/main/home-bas";
          };

          ayuhdd = genericShareSettings // {
            "valid users" = "ayu";
            comment = "ayuhdd share";
            path = "/zbig/main/ayuhdd";
          };
        };
    };
  };
}
