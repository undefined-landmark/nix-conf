{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.sops;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../universal/sops-setup.nix
  ];

  config = lib.mkIf cfg.enable {
    custom-modules-universal.sops-setup = {
      enable = cfg.enable;
      sepHomeDrive = cfg.sepHomeDrive;
    };
  };
}
