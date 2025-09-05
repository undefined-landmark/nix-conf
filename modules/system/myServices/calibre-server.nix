{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.calibre-server;
in {
  config = lib.mkIf cfg.enable {
    services.calibre-server = {
      enable = true;
      group = config.myServices.mediagroup;
      port = 8181;
      libraries = ["/var/lib/calibre-server/library"];
      auth = {
        enable = true;
        userDb = "/var/lib/calibre-server/users/users.sqlite";
      };
      extraFlags = [
        "--ban-after=10"
        "--disable-use-bonjour"
      ];
    };

    myServices.traefik.params = [
      {
        subdomain = "calibre";
        port = toString config.services.calibre-server.port;
      }
    ];
  };
}
