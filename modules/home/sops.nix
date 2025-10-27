{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.myHome.sops;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../universal/sops-setup.nix
  ];

  config = lib.mkIf cfg.enable {
    myUniv.sops-setup = {
      enable = cfg.enable;
      sepHomeDrive = cfg.sepHomeDrive;
    };
  };
}
