{
  lib,
  config,
  ...
}: let
  cfg = config.myServer;
  username = config.users.users.bas.name;
in {
  config = lib.mkIf cfg.enable {
    powerManagement.powertop.enable = true;

    users.groups."${cfg.mediagroup}" = {};
    users.users.bas.extraGroups = ["${cfg.mediagroup}"];

    # So that --target-host can function
    nix.settings.trusted-users = [username];
  };
}
