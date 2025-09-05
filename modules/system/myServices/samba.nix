{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.samba;
in {
  config = lib.mkIf cfg.enable {
    users.users.bas-smb = {
      isNormalUser = true;
      description = "bas-smb";
      createHome = false;
    };

    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          security = "user";
          "server string" = "ecoboxsamba";
          "hosts allow" = ["192.168.2." "172.17.0."];
        };

        # Share settings
        ecoshare = {
          comment = "main share folder";
          path = "/mnt/smb/alles";
          "valid users" = "bas-smb";
          browseable = "no";
          writable = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };
  };
}
