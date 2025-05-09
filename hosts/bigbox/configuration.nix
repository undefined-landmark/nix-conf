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

  networking.hostName = "bigbox"; # Define your hostname.
  networking.hostId = "c1f34d19";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  custom-modules = {
    enable = true;
    bootloader-swap.enable = true;
    desktop-environment.enable = true;
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
