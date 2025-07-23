{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.myServer;
in {
  imports = [
    "${inputs.master}/nixos/modules/services/torrent/qbittorrent.nix"
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
    
    myServer.traefikDynamic = [
      {
        subdomain = "qbittorrent";
        port = toString config.services.qbittorrent.webuiPort;
      }
    ];
  };
}
