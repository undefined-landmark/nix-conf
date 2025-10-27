{
  lib,
  config,
  ...
}:
let
  cfg = config.myServer;
  username = config.users.users.bas.name;
in
{
  imports = [
    ./postgresqlBackup.nix
    ./remote-unlock.nix
    ./ssh.nix
  ];

  options.myServer = {
    enable = lib.mkEnableOption "Server setup";
  };

  config = lib.mkIf cfg.enable {
    powerManagement.powertop.enable = true;

    # So that --target-host can function
    nix.settings.trusted-users = [ username ];
  };
}
