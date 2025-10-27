{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.immich;
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

    myServices.traefik.params = [
      {
        subdomain = "immich";
        port = toString config.services.immich.port;
      }
    ];
  };
}
