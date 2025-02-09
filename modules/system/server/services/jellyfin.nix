{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
    };
  };
}
