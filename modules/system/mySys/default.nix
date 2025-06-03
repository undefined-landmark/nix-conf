{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mySys;
in {
  imports = [
    ./bootloader-swap.nix
    ./general.nix
    ./restic.nix
    ./nvidia.nix
    ./sops.nix
    ./stylix.nix
    ./virtualisation.nix
    ./wg-quick.nix
    inputs.my-secrets.private-vars
  ];

  options.mySys = {
    enable = lib.mkEnableOption "Custom system modules";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.private.enable = true;
  };
}
