{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
  baseDomain = cfg.baseDomain;
  traefikAdd = import ./traefikAdd.nix;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      group = cfg.mediagroup;
    };

    services.traefik.dynamicConfigOptions = traefikAdd {
      domain = baseDomain;
      subdomain = "jellyfin";
      port = "8096";
    };
  };
}
