{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  imports = [
    "${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"
    ./portChecker.nix
  ];

  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = cfg.mediagroup;
      openFirewall = true;
    };

    cfg.traefikDynamic = [
      {
        subdomain = "qbittorrent";
        port = toString config.services.qbittorrent.webuiPort;
      }
    ];
  };
}
