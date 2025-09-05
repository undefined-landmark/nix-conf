{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
in {
  config = lib.mkIf cfg.enable {
    services.scrutiny = {
      enable = false;
      settings.web.listen.port = 8111;
      collector.schedule = "daily";
    };

    myServices.traefikDynamic = [
      {
        subdomain = "scrutiny";
        port = toString config.services.scrutiny.settings.web.listen.port;
      }
    ];
  };
}
