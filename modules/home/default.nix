{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.myHome;
in {
  imports = [
    ./autorandr.nix
    ./ayu.nix
    ./bas.nix
    ./general.nix
    ./i3.nix
    ./pkgs-cli
    ./pkgs-gui
    ./sops.nix
    inputs.my-secrets.privateVars
  ];

  options.myHome = {
    enable = lib.mkEnableOption "Custom home-manager modules";
    user = lib.mkOption {
      type = lib.types.str;
      description = ''
        User in home-manager
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    my-secrets.private.enable = true;
  };
}
