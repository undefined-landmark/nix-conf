{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

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
    x11.enable = true;
    audio.enable = true;
    nvidia.enable = true;
    stylix.enable = true;
    general.enable = true;
    wg-quick = {
      enable = true;
      autostart-east = true;
    };
    samba-mount.enable = true;
  };
}
