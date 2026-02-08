{
  inputs,
  config,
  pkgsUnstable,
  ...
}:
{
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
    extraSpecialArgs = { inherit inputs pkgsUnstable; };
    users = {
      "bas" = import ./home-bas.nix;
      "ayu" = import ./home-ayu.nix;
    };
  };

  users.users.ayu = {
    isNormalUser = true;
    description = "ayu";
  };

  mySys = {
    enable = true;
    sops = {
      enable = true;
      sepHomeDrive = true;
    };
    general.enable = true;
    nvidia.enable = true;
    bootloader-swap.enable = true;
    virtualisation.enable = false;
    wg-quick = {
      enable = true;
      hostname = config.networking.hostName;
    };
    stylix.enable = true;
  };

  myDE = {
    enable = true;
    kde.enable = true;
  };
}
