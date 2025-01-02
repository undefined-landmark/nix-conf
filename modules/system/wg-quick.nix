{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.wg-quick;
in {
  imports = [./sops.nix];

  options.custom-modules.wg-quick = {
    enable = lib.mkEnableOption "wg-quick setup";
    autostart-east = lib.mkEnableOption "autostart wireguard east";
    autostart-west = lib.mkEnableOption "autostart wireguard west";
    autostart-proton = lib.mkEnableOption "autostart wireguard proton";
  };

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;
    sops.secrets.lightbox-wg-east = {};
    sops.secrets.lightbox-wg-west = {};
    sops.secrets.lightbox-wg-proton = {};

    networking.wg-quick.interfaces = {
      east = {
        configFile = config.sops.secrets.lightbox-wg-east.path;
        autostart = cfg.autostart-east;
      };
      west = {
        configFile = config.sops.secrets.lightbox-wg-west.path;
        autostart = cfg.autostart-west;
      };
      proton = {
        configFile = config.sops.secrets.lightbox-wg-proton.path;
        autostart = cfg.autostart-proton;
      };
    };
  };
}
