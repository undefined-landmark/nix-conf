{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-home-modules;
in {
  imports = [
    ./i3.nix
    ./general.nix
    ./pkgs-cli
    ./pkgs-gui
    ./autorandr.nix
    inputs.my-secrets.private-vars
    inputs.my-secrets.homeManagerModules.my-secrets
  ];

  options.custom-home-modules = {
    enable = lib.mkEnableOption "Custom home-manager modules";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.private.enable = true;
    my-secrets.sops-hm.enable = true;
  };
}
