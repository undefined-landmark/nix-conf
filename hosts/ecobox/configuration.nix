{
  inputs,
  config,
  pkgsUnstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
    ../../modules/system
  ];

  config = {
    networking.hostName = "ecobox";
    networking.hostId = "5b8660bf";

    boot.supportedFilesystems = ["zfs"];
    boot.zfs.forceImportRoot = false;

    services.zfs.autoScrub.enable = true;

    home-manager = {
      extraSpecialArgs = {inherit inputs pkgsUnstable;};
      users = {
        "bas" = import ./home.nix;
      };
    };

    mySys = {
      enable = true;
      sops.enable = true;
      general.enable = true;
      bootloader-swap.enable = true;
      restic = {
        enable = true;
        hostname = config.networking.hostName;
      };
      wg-quick = {
        enable = true;
        hostname = config.networking.hostName;
      };
    };

    myServer = {
      enable = true;
      ssh.enable = true;
      postgresqlBackup.enable = true;
      remote-unlock.enable = true;
    };

    myServices = {
      enable = true;
      baseDomain = config.my-secrets.private.vars.domain;
      arr.enable = true;
      calibre-server.enable = true;
      cross-seed.enable = true;
      grafana.enable = true;
      homepage.enable = true;
      jellyfin.enable = true;
      paperless.enable = true;
      prometheus.enable = true;
      qbittorrent.enable = true;
      resticServer = {
        enable = true;
        dataDir = "/zbig/main/restic-server";
        subdomain = "restic-west";
      };
      samba.enable = true;
      tandoor.enable = true;
      traefik.enable = true;
    };
  };
}
