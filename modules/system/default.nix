{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules;
in {
  imports = [
    ./server
    ./workstation
    ./restic.nix
    ./general.nix
    ./wg-quick.nix
    ./bootloader-swap.nix
    inputs.my-secrets.private-vars
    inputs.my-secrets.nixosModules.my-secrets
  ];

  options.custom-modules = {
    enable = lib.mkEnableOption "Custom system modules";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.sops-sys.enable = true;
    my-secrets.set-private.enable = true;
  };
}
