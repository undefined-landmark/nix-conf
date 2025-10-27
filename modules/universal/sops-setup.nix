{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.myUniv.sops-setup;
  keyLocation =
    if cfg.sepHomeDrive then "/etc/sops/age/keys.txt" else "/home/bas/.config/sops/age/keys.txt";
  sharedOptions = {
    enable = lib.mkEnableOption "sops-nix settings";
    sepHomeDrive = lib.mkOption {
      type = lib.types.bool;
      description = ''
        If the home directory is located on another drive than root. When this
        is the case the home directory will not be mounted early enough during
        boot. Therefore we need to safe the age keys somewhere else.
      '';
      default = false;
    };
  };
in
{
  options = {
    myUniv.sops-setup = sharedOptions;
    myHome.sops = sharedOptions;
    mySys.sops = sharedOptions;
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = keyLocation;
      defaultSopsFile = inputs.my-secrets.sopsSecrets;
    };
  };
}
