{
  inputs,
  config,
  pkgsUnstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
    ../../modules/system
  ];

  config = {
    networking.hostName = "ecobox";
    networking.hostId = "5b8660bf";

    boot.supportedFilesystems = ["zfs"];
    boot.zfs.forceImportRoot = false;

    services.zfs.autoScrub.enable = true;

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
      restic = {
        enable = true;
        hostname = config.networking.hostName;
      };
      wg-quick = {
        enable = true;
        hostname = config.networking.hostName;
      };
    };

    myServer = {
      enable = true;
      mediagroup = "medialab";
      baseDomain = config.my-secrets.private.vars.domain;
    };
  };
}
