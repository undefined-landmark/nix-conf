{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/system
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

  networking.hostName = "bigbox"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  custom-modules = {
    enable = true;
    x11.enable = true;
    sops.enable = true;
    audio.enable = true;
    stylix.enable = true;
    general.enable = true;
    #wg-quick.enable = true;
    samba-mount.enable = true;
  };
}
