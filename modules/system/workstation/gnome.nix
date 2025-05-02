{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.gnome;
in {
  options.custom-modules.gnome = {
    enable = lib.mkEnableOption "Setup gnome";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
