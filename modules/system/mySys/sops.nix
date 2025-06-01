{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mySys.sops;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../../universal/sops-setup.nix
  ];

  config = lib.mkIf cfg.enable {
    myUniv.sops-setup = {
      enable = cfg.enable;
      sepHomeDrive = cfg.sepHomeDrive;
    };
  };
}
