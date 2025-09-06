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

    myServer = {
      enable = true;
      ssh.enable = true;
    };

    myServices = {
      enable = true;
      baseDomain = config.my-secrets.private.vars.domain;
      resticServer = {
        enable = true;
        dataDir = "/zbig/main/restic-server";
        subdomain = "restic-east";
      };
      traefik.enable = true;
    };
  };
}
