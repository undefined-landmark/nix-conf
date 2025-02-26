{inputs, config, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "lightbox"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  services.tlp.enable = true;
  services.upower.enable = true;
  services.fstrim.enable = true;

  custom-modules = {
    enable = true;
    general.enable = true;
    bootloader-swap.enable = true;
    wg-quick = {
      enable = true;
      hostname = config.networking.hostName;
    };
    desktop-environment.enable = true;
  };
}
