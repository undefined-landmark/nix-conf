{inputs, config, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;

  networking.hostName = "lightbox"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  services.tlp.enable = true;
  services.upower.enable = true;

  custom-modules = {
    enable = true;
    general.enable = true;
    wg-quick = {
      enable = true;
      hostname = config.networking.hostName;
    };
    desktop-environment.enable = true;
  };
}
