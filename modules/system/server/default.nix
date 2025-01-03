{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  imports = [
    ./ssh.nix
    ./samba.nix
  ];

  options.custom-modules.server = {
    enable = lib.mkEnableOption "Server setup";
  };

  config = lib.mkIf cfg.enable {
    config.custom-modules.server-ssh.enable = true;
    config.custom-modules.server-samba.enable = true;
    powerManagement.powertop.enable = true;
  };
}
