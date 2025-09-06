{
  inputs,
  config,
  pkgsUnstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system
  ];

  config = {
    networking.hostName = "tinybox";

    home-manager = {
      extraSpecialArgs = {inherit inputs pkgsUnstable;};
      users = {
        "bas" = import ./home.nix;
      };
    };

    mySys = {
      enable = true;
      sops.enable = true;
      general.enable = true;
      bootloader-swap.enable = true;
    };

    myServer.enable = true;

    myServices = {
      enable = true;
      mediagroup = "medialab";
      baseDomain = config.my-secrets.private.vars.domain;
      resticServer.enable = true;
      traefik.enable = true;
    };
  };
}
