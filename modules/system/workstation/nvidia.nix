{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.nvidia;
in {
  options.custom-modules.nvidia = {
    enable = lib.mkEnableOption "nvidia setup";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
