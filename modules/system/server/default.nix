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
    custom-modules.server-ssh.enable = true;
    custom-modules.server-samba.enable = true;
    powerManagement.powertop.enable = true;
  };
}
