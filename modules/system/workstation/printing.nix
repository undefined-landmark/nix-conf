{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi.enable = true;
  };
}
