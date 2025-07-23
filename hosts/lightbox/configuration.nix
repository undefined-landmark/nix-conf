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

  networking.hostName = "lightbox"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = {inherit inputs pkgsUnstable;};
    users = {
      "bas" = import ./home-bas.nix;
      "ayu" = import ./home-ayu.nix;
    };
  };

  # Only two user on the lightbox setup
  users.users.ayu = {
    isNormalUser = true;
    description = "ayu";
  };

  services.upower.enable = true;
  services.fstrim.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  mySys = {
    enable = true;
    sops.enable = true;
    general.enable = true;
    bootloader-swap.enable = true;
    virtualisation.enable = true;
    wg-quick = {
      enable = true;
      hostname = config.networking.hostName;
    };
    stylix.enable = true;
    restic = {
      enable = true;
      hostname = config.networking.hostName;
    };
  };

  myDE = {
    enable = true;
    kde.enable = true;
  };
}
