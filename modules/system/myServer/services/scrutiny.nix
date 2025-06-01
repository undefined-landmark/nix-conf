{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.server;
in {
  config = lib.mkIf cfg.enable {
    services.scrutiny = {
      enable = true;
      settings.web.listen.port = 8111;
      collector.schedule = "daily";
    };

    mySys.server.traefikDynamic = [
      {
        subdomain = "scrutiny";
        port = toString config.services.scrutiny.settings.web.listen.port;
      }
    ];
  };
}
