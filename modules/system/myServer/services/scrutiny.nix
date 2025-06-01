{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    services.scrutiny = {
      enable = true;
      settings.web.listen.port = 8111;
      collector.schedule = "daily";
    };

    myServer.traefikDynamic = [
      {
        subdomain = "scrutiny";
        port = toString config.services.scrutiny.settings.web.listen.port;
      }
    ];
  };
}
