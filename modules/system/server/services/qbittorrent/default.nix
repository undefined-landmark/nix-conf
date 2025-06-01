{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mySys.server;
in {
  imports = [
    "${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"
    ./portChecker.nix
    ./dynamicApiUpdater.nix
  ];

  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = cfg.mediagroup;
    };

    mySys.server.traefikDynamic = [
      {
        subdomain = "qbittorrent";
        port = toString config.services.qbittorrent.webuiPort;
      }
    ];
  };
}
