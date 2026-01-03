{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myServices.qbittorrent;
in
{
  imports = [
    ./portChecker.nix
    ./dynamicApiUpdater.nix
  ];

  options.myServices.qbittorrent.enable = lib.mkEnableOption "Setup qbittorrent";

  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8888;
      group = config.myServices.mediagroup;
    };

    systemd.services.qbittorrent = {
      # To use curl in "external program"
      path = [ pkgs.curl ];
      # So files have 664 permissions and dirs 775
      serviceConfig.UMask = "0002";
    };

    myServices.traefik.params = [
      {
        subdomain = "qbittorrent";
        port = toString config.services.qbittorrent.webuiPort;
      }
    ];
  };
}
