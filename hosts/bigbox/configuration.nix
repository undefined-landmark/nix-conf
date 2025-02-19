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

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  custom-modules = {
    enable = true;
    nvidia.enable = true;
    restic.enable = true;
    general.enable = true;
    bootloader-swap.enable = true;
        #wg-quick = {
        #  enable = true;
        #  hostname = config.networking.hostName;
        #};
    desktop-environment.enable = true;
  };
}
