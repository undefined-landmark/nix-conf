{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.myServices.qui;
in
{
  imports = [ "${inputs.qui}/nixos/modules/services/torrent/qui.nix" ];

  options.myServices.qui.enable = lib.mkEnableOption "Setup qui";

  config = lib.mkIf cfg.enable {
    sops.secrets.qui-secret = { };

    services.qui = {
      enable = true;
      secretFile = config.sops.secrets.qui-secret.path;
      settings.checkForUpdates = false;
    };

    myServices.traefik.params = [
      {
        subdomain = "qui";
        port = toString config.services.qui.settings.port;
      }
    ];
  };
}
