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
  };

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;
    sops.secrets.lightbox-wg-east = {};
    sops.secrets.lightbox-wg-west = {};
    sops.secrets.lightbox-wg-proton = {};

    networking.wg-quick.interfaces = {
      east = {
        configFile = config.sops.secrets.lightbox-wg-east.path;
        autostart = false;
      };
      west = {
        configFile = config.sops.secrets.lightbox-wg-west.path;
        autostart = false;
      };
      proton = {
        configFile = config.sops.secrets.lightbox-wg-proton.path;
        autostart = true;
      };
    };
  };
}
