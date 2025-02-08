{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["bas"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
