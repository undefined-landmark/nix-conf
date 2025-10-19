{
  inputs,
  config,
  lib,
  pkgsUnstable,
  modulesPath,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/system
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  config = {
    nixpkgs.hostPlatform = "aarch64-linux";
    networking = {
      hostName = "tinybox";
      useDHCP = lib.mkDefault true;
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs pkgsUnstable; };
      users = {
        "bas" = import ./home.nix;
      };
    };

    # These options should make the sd card image build faster
    boot.supportedFilesystems.zfs = lib.mkForce false;
    sdImage.compressImage = false;

    mySys = {
      enable = true;
      sops.enable = true;
      general.enable = true;
    };

    myServer = {
      enable = true;
      ssh.enable = true;
    };

    myServices = {
      enable = true;
      baseDomain = config.my-secrets.private.vars.domain;
      resticServer = {
        enable = true;
        dataDir = "/zbig/main/restic-server";
        subdomain = "restic-east";
      };
      traefik.enable = true;
    };
  };
}
