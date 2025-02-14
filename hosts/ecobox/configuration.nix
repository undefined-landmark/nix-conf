{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system
  ];

  config = {
    custom-modules.private-vars.enable = true;

    networking.hostName = "ecobox";

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "bas" = import ./home.nix;
      };
    };

    custom-modules = {
      enable = true;
      general.enable = true;
      bootloader-swap.enable = true;
      wg-quick = {
        enable = true;
        hostname = config.networking.hostName;
      };
      server = {
        enable = true;
        mediagroup = "medialab";
        baseDomain = config.my-secrets.private.vars.domain;
      };
    };
  };
}
