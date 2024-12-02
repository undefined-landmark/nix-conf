{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../system/stylix.nix
    ../../system/x11.nix
    ../../system/general.nix
    ../../system/audio.nix
    ../../system/sops.nix
    ../../system/wg-quick.nix
    ../../system/samba-mount.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;

  networking.hostName = "lightbox"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  services.tlp.enable = true;
}
