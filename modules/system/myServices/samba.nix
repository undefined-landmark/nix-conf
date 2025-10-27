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
    users.users.bas-smb = {
      isNormalUser = true;
      description = "bas-smb";
      createHome = false;
    };

    services.samba = {
      enable = true;
      openFirewall = true;
      settings =
        let
          genericShareSettings = {
            "valid users" = "bas-smb";
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
          general = genericShareSettings // {
            comment = "general share";
            path = "/mnt/smb/alles";
          };

          video = genericShareSettings // {
            comment = "video share";
            path = "/zbig/main/home-bas/videos";
          };

          photo = genericShareSettings // {
            comment = "photo share";
            path = "/zbig/main/home-bas/Pictures";
          };
        };
    };
  };
}
