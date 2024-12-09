{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.sops;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  options.custom-modules.sops = {
    enable = lib.mkEnableOption "sops-nix setup";
  };

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = "/home/bas/.config/sops/age/keys.txt";
    sops.defaultSopsFile = "${inputs.secrets}/secrets/ssh.yaml";
  };
}
