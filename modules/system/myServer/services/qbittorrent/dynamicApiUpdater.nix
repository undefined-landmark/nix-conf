{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.myServer;
  dynamicApiScript = builtins.readFile inputs.my-secrets.dynamicApiScript;
  dynamicApiIdPath = config.sops.secrets.dynamicApiId.path;
  dynamicApiApp = pkgs.writeShellApplication {
    name = "dynamicApiApp";
    runtimeInputs = [pkgs.curl pkgs.libnatpmp];
    text = builtins.replaceStrings ["./id_path"] [dynamicApiIdPath] dynamicApiScript;
  };
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.dynamicApiId = {
      mode = "0440";
      owner = config.services.qbittorrent.user;
      group = config.services.qbittorrent.group;
    };

    systemd.services.dynamicApiUpdater = {
      description = "Dynamic API IP updater";
      after = [
        "network.target"
        "wg-quick-protonfw.service"
      ];
      requires = ["wg-quick-protonfw.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = config.services.qbittorrent.user;
        Group = config.services.qbittorrent.group;
        DynamicUser = true;
        StateDirectory = "dynamicApi";
        ExecStart = lib.getExe dynamicApiApp;
        Restart = "on-failure";
        RestartSec = 20;
      };
    };
  };
}
