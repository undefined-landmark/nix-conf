{
  lib,
  config,
  ...
}: let
  cfg = config.myServices.samba;
in {
  config = lib.mkIf cfg.enable {
    services.scrutiny = {
      enable = true;
      settings.web.listen.port = 8111;
      collector.schedule = "daily";
    };

    myServices.traefik.params = [
      {
        subdomain = "scrutiny";
        port = toString config.services.scrutiny.settings.web.listen.port;
      }
    ];
  };
}
