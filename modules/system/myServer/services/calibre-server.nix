{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    services.calibre-server = {
      enable = true;
      group = cfg.mediagroup;
      port = 8181;
      libraries = ["/var/lib/calibre-server/library"];
      auth = {
        enable = true;
        userDb = "/var/lib/calibre-server/users/users.sqlite";
      };
      extraFlags = ["--ban-after=10"];
    };

    myServer.traefikDynamic = [
      {
        subdomain = "calibre";
        port = toString config.services.calibre-server.port;
      }
    ];
  };
}
