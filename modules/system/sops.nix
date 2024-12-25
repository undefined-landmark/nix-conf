{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.sops;
in {
  imports = [inputs.my-secrets.nixosModules.my-secrets];

  options.custom-modules.sops = {
    enable = lib.mkEnableOption "sops-nix nixOS setup";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.sops-sys.enable = true;
  };
}
