{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.myUniv.sops-setup;
  sharedOptions = {
    enable = lib.mkEnableOption "sops-nix settings";
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
      age.keyFile = "/home/bas/.config/sops/age/keys.txt";
      defaultSopsFile = inputs.my-secrets.sopsSecrets;
    };
  };
}
