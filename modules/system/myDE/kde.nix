{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.kde;
in {
  options.mySys.kde = {
    enable = lib.mkEnableOption "Setup kde";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
