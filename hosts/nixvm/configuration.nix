{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;

  networking.hostName = "nixvm";

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bas" = import ./home.nix;
    };
  };

  mySys = {
    enable = true;
    general.enable = true;
    wg-quick = {
      enable = true;
      autostart-east = true;
    };
    server.enable = true;
  };
}
