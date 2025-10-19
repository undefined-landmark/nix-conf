{
  lib,
  config,
  ...
}:
let
  cfg = config.mySys.virtualisation;
in
{
  options.mySys.virtualisation = {
    enable = lib.mkEnableOption "Setup virtualisation";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    users.groups.libvirtd.members = [ "bas" ];

    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
      podman.enable = true;
    };
  };
}
