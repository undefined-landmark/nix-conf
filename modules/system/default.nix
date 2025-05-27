{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules;
in {
  imports = [
    ./bootloader-swap.nix
    ./general.nix
    ./restic.nix
    ./server
    ./sops.nix
    ./wg-quick.nix
    ./workstation
    inputs.my-secrets.private-vars
  ];

  options.custom-modules = {
    enable = lib.mkEnableOption "Custom system modules";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.private.enable = true;
  };
}
