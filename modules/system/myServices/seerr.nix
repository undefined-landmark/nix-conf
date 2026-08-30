{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.seerr;
in
{
  options.myServices.seerr.enable = lib.mkEnableOption "Setup seerr";

  config = lib.mkIf cfg.enable {
    services.seerr.enable = true;

    myServices.traefik.params = [
      {
        subdomain = "seerr";
        port = toString cfg.port;
      }
    ];
  };
}
