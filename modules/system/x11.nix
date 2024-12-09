{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.x11;
in {
  options.custom-modules.x11 = {
    enable = lib.mkEnableOption "x11 setting";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    services.displayManager = {
      defaultSession = "none+i3";
    };

    programs.xfconf.enable = true;

    services.libinput = {
      touchpad.naturalScrolling = true;
      mouse.naturalScrolling = true;
    };
  };
}
