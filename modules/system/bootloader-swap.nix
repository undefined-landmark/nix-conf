{
  lib,
  config,
  ...
}: let
  cfg = config.mySys.bootloader-swap;
in {
  options.mySys.bootloader-swap = {
    enable = lib.mkEnableOption "Setup systemd-boot and zramSwap";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    zramSwap.enable = true;
  };
}
