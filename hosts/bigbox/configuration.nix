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

  networking.hostName = "bigbox";
  networking.hostId = "c1f34d19";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = ./home-bas.nix;
      "ayu" = ./home-ayu.nix;
    };
  };

  users.users.ayu = {
    isNormalUser = true;
    description = "ayu";
  };

  custom-modules = {
    enable = true;
    sops = {
      enable = true;
      sepHomeDrive = true;
    };
    bootloader-swap.enable = true;
    kde.enable = true;
    general.enable = true;
    nvidia.enable = true;
    restic = {
      enable = true;
      hostname = config.networking.hostName;
    };
    stylix.enable = true;
    wg-quick = {
      enable = true;
      hostname = config.networking.hostName;
    };
  };
}
