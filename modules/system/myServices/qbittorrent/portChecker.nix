{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myServices;
  portScript = builtins.readFile ./portChecker.sh;
  creds_path = config.sops.secrets.qbittorrent_post_creds.path;
  portApp = pkgs.writeShellApplication {
    name = "qbit-natpmp-port";
    runtimeInputs = [pkgs.curl pkgs.libnatpmp];
    text = builtins.replaceStrings ["./creds_path"] [creds_path] portScript;
  };
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.qbittorrent_post_creds = {
      mode = "0440";
      owner = config.services.qbittorrent.user;
      group = config.services.qbittorrent.group;
    };

    systemd.services.qbitPortCheck = {
      description = "Get and set NAT-PMP port for qBittorrent";
      after = [
        "network.target"
        "qbittorrent.service"
        "wg-quick-protonfw.service"
      ];
      requires = [
        "qbittorrent.service"
        "wg-quick-protonfw.service"
      ];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = config.services.qbittorrent.user;
        Group = config.services.qbittorrent.group;
        DynamicUser = true;
        StateDirectory = "qbitPortCheck";
        ExecStart = lib.getExe portApp;
        Restart = "on-failure";
        RestartSec = 20;
      };
    };
  };
}
