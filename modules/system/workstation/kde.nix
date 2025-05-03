{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.kde;
in {
  options.custom-modules.kde = {
    enable = lib.mkEnableOption "Setup kde";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
