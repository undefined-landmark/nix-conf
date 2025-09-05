{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
  fileServices = [
    "arr"
    "calibre-server"
    "cross-seed"
    "homepage"
    "jellyfin"
    "paperless"
    "prometheus_grafana"
    "resticServer"
    "samba"
    "scrutiny"
    "tandoor"
    "traefik"
    "traefik.params"
  ];
  dirServices = [
    "qbittorrent"
  ];
  fileServicePaths = builtins.map (x: ./. + "/${x}.nix") fileServices;
  dirServicePaths = builtins.map (x: ./. + "/${x}") fileServices;
  servicePaths = fileServicePaths ++ dirServicePaths;
  serviceNames = fileServices ++ dirServices;

  servicesEnableOptions =
    lib.genAttrs
    serviceNames
    (name: {enable = lib.mkEnableOption "${name} setup";});
in {
  imports = servicePaths;

  options.myServices =
    {
      enable = lib.mkEnableOption "Server setup";
      mediagroup = lib.mkOption {
        type = lib.types.str;
        description = "Group that should be used to run media related applications";
      };
      baseDomain = lib.mkOption {
        type = lib.types.str;
        description = "Domain name that should be used for the reverse proxy";
      };
      traefik.params = lib.mkOption {
        type = lib.types.listOf (lib.types.attrsOf lib.types.str);
        description = ''
          List of attributesets containing parameters to generate traefik.paramsConfigOptions routers en services.
        '';
      };
    }
    // servicesEnableOptions;

  config = lib.mkIf cfg.enable {
    users.groups."${cfg.mediagroup}" = {};
    users.users.bas.extraGroups = ["${cfg.mediagroup}"];
  };
}
