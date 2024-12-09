{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-home-modules.sops;
in {
  options.custom-home-modules.sops = {
    enable = lib.mkEnableOption "sops-nix setup";
  };

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = "/home/bas/.config/sops/age/keys.txt";
    sops.defaultSopsFile = "${inputs.secrets}/secrets/ssh.yaml";
  };
}
