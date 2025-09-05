{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
  sopsPh = config.sops.placeholder;
  baseDomain = cfg.baseDomain;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.prowlarr-api_key = {};
    sops.secrets.radarr-api_key = {};
    sops.secrets.sonarr-api_key = {};
    sops.secrets.qbit_creds = {};
    sops.secrets.cross-seed_api-key = {};

    sops.templates."cross-seed_secrets.json" = {
      content = ''
        {
          "torznab": [
            "https://prowlarr.${baseDomain}/1/api?apikey=${sopsPh.prowlarr-api_key}",
            "https://prowlarr.${baseDomain}/2/api?apikey=${sopsPh.prowlarr-api_key}",
            "https://prowlarr.${baseDomain}/3/api?apikey=${sopsPh.prowlarr-api_key}",
            "https://prowlarr.${baseDomain}/4/api?apikey=${sopsPh.prowlarr-api_key}"
          ],
          "sonarr": ["https://sonarr.${baseDomain}/?apikey=${sopsPh.sonarr-api_key}"],
          "radarr": ["https://radarr.${baseDomain}/?apikey=${sopsPh.radarr-api_key}"],
          "qbittorrentUrl": "https://${sopsPh.qbit_creds}@qbittorrent.${baseDomain}",
          "apiKey": "${sopsPh.cross-seed_api-key}"
        }
      '';
      owner = config.services.cross-seed.user;
    };

    services.cross-seed = {
      enable = true;
      user = config.services.qbittorrent.user;
      group = cfg.mediagroup;
      useGenConfigDefaults = true;
      settingsFile = config.sops.templates."cross-seed_secrets.json".path;
      settings = {
        matchMode = "partial";
        linkDirs = ["/mnt/medialab/torrent/xseed/linkdir"];
        delay = 60;
        searchLimit = 100;
        rssCadence = "1 hour";
      };
    };
  };
}
