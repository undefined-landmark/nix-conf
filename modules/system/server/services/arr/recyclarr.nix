{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/recyclarr.nix"
  ];

  config = lib.mkIf cfg.enable {
    sops.secrets.radarr-api_key = {};
    sops.secrets.sonarr-api_key = {};

    systemd.services.recyclarr.serviceConfig.LoadCredential = [
      "radarr-api_key:${config.sops.secrets.radarr-api_key.path}"
      "sonarr-api_key:${config.sops.secrets.sonarr-api_key.path}"
    ];

    services.recyclarr = {
      enable = true;
      configuration = {
        radarr = config.my-secrets.private.vars.radarrConfig;
        sonarr = config.my-secrets.private.vars.sonarrConfig;
      };
    };
  };
}
