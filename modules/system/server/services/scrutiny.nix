{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  config = lib.mkIf cfg.enable {
    services.scrutiny = {
      enable = true;
      settings.web.listen.port = 8111;
      collector.schedule = "daily";
    };

    custom-modules.server.traefikDynamic = [
      {
        subdomain = "scrutiny";
        port = toString config.services.scrutiny.settings.web.listen.port;
      }
    ];
  };
}
