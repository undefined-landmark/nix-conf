{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-home-modules.sops;
in {
  imports = [inputs.my-secrets.homeManagerModules.my-secrets];

  options.custom-home-modules.sops = {
    enable = lib.mkEnableOption "sops-nix home-manager setup";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.sops-hm.enable = true;
  };
}
