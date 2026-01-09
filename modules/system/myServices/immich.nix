{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.immich;
  externalLibPaths = config.my-secrets.private.vars.immichExternalLibPaths;
in
{
  options.myServices.immich = {
    enable = lib.mkEnableOption "Setup immich";
    photogroup = lib.mkOption {
      type = lib.types.str;
      default = "photos";
      description = "Group that should be used to run media related applications";
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      groups."${cfg.photogroup}" = { };
      users.bas.extraGroups = [ "${cfg.photogroup}" ];
    };

    services.immich = {
      enable = true;
      group = cfg.photogroup;
      mediaLocation = "/zbig/main/home-bas/Pictures/photos/immich";
      database.enableVectors = false;
    };

    systemd.services = {
      immich-server.serviceConfig.ReadOnlyPaths = externalLibPaths;
      immich-machine-learning.serviceConfig.ReadOnlyPaths = externalLibPaths;
    };

    myServices.traefik.params = [
      {
        subdomain = "immich";
        port = toString config.services.immich.port;
      }
    ];
  };
}
