{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.private-vars;
in {
  imports = [inputs.my-secrets.private-vars];

  options.custom-modules.private-vars = {
    enable = lib.mkEnableOption "Load private variables from secret flake";
  };

  config = lib.mkIf cfg.enable {
    my-secrets.set-private.enable = true;
  };
}
