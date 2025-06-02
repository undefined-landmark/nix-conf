{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.gnome;
in {
  options.mySys.gnome = {
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
