{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-home-modules.sops;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../universal/sops-setup.nix
  ];

  config = lib.mkIf cfg.enable {
    custom-modules-universal.sops-setup = {
      enable = cfg.enable;
      sepHomeDrive = cfg.sepHomeDrive;
    };
  };
}
