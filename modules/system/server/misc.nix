{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  config = lib.mkIf cfg.enable {
    powerManagement.powertop.enable = true;

    users.groups."${cfg.mediagroup}" = {};
  };
}
