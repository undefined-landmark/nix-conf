{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.thelounge;
in
{
  options.myServices.thelounge.enable = lib.mkEnableOption "Setup thelounge";

  config = lib.mkIf cfg.enable {
    services.thelounge.enable = true;

    myServices.traefik.params = [
      {
        subdomain = "thelounge";
        port = toString config.services.thelounge.port;
      }
    ];
  };
}
