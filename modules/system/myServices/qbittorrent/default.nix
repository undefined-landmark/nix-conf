{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
in {
  imports = [
    ./portChecker.nix
    ./dynamicApiUpdater.nix
  ];

  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = cfg.mediagroup;
    };

    systemd.services.qbittorrent.serviceConfig.UMask = "0002";

    myServices.traefikDynamic = [
      {
        subdomain = "qbittorrent";
        port = toString config.services.qbittorrent.webuiPort;
      }
    ];
  };
}
