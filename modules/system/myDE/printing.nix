{
  lib,
  config,
  ...
}: let
  cfg = config.myDE.i3;
in {
  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi.enable = true;
  };
}
