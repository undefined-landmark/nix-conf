{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.bootloader-swap;
in {
  options.custom-modules.bootloader-swap = {
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
