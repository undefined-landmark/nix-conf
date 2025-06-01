{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
in {
  config = lib.mkIf cfg.enable {
    powerManagement.powertop.enable = true;

    users.groups."${cfg.mediagroup}" = {};
    users.users.bas.extraGroups = ["${cfg.mediagroup}"];
  };
}
