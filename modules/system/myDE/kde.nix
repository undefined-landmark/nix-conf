{
  lib,
  config,
  ...
}:
let
  cfg = config.myDE.kde;
in
{
  options.myDE.kde = {
    enable = lib.mkEnableOption "Setup kde";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # To avoid audio crackling?
    security.rtkit.enable = true;
  };
}
