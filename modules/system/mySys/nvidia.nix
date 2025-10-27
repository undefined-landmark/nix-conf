{
  lib,
  config,
  ...
}:
let
  cfg = config.mySys.nvidia;
in
{
  options.mySys.nvidia = {
    enable = lib.mkEnableOption "nvidia setup";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

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
