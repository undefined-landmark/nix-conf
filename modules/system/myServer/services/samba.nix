{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.server;
in {
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /mnt/smb/alles 0755 bas users - -"
    ];

    services.samba = {
      enable = true;
      openFirewall = true;
      smbd.enable = true;
      settings = {
        global = {
          "server string" = "ecobox-samba";
          "hosts allow" = ["192.168.2." "172.17.0."];
        };

        # Share settings
        alles = {
          comment = "main share folder";
          path = "/mnt/smb/alles";
          "valid users" = "bas";
          public = "no";
          writable = "yes";
          printable = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };
  };
}
