{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices;
in
{
  imports = [
    ./arr.nix
    ./calibre-server.nix
    ./cross-seed.nix
    ./grafana.nix
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./paperless.nix
    ./prometheus.nix
    ./qbittorrent
    ./resticServer.nix
    ./samba.nix
    ./scrutiny.nix
    ./tandoor.nix
    ./traefik.nix
    ./traefikDynamic.nix
  ];

  options.myServices = {
    enable = lib.mkEnableOption "Server setup";
    mediagroup = lib.mkOption {
      type = lib.types.str;
      default = "medialab";
      description = "Group that should be used to run media related applications";
    };
    baseDomain = lib.mkOption {
      type = lib.types.str;
      description = "Domain name that should be used for the reverse proxy";
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      groups."${cfg.mediagroup}" = { };
      users.bas.extraGroups = [ "${cfg.mediagroup}" ];
    };
  };
}
