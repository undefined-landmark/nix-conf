{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.myServices.nemorosa;
in
{
  imports = [ "${inputs.nemorosa}/nixos/modules/services/torrent/nemorosa.nix" ];

  options.myServices.nemorosa.enable = lib.mkEnableOption "Setup nemorosa";

  config = lib.mkIf cfg.enable {
    sops.secrets = {
      nemorosa_qbit-url = { };
      nemorosa_tracker1-url = { };
      nemorosa_tracker1-api = { };
      nemorosa_tracker2-url = { };
      nemorosa_tracker2-api = { };
    };

    services.nemorosa = {
      enable = true;
      group = config.myServices.mediagroup;
      settings = {
        server = {
          search_cadence = "4 weeks";
          cleanup_cadence = "4 weeks";
        };
        linking = {
          enable_linking = true;
          link_dirs = [ "/mnt/medialab/torrent/nemorosa" ];
        };
        downloader.client._secret = config.sops.secrets.nemorosa_qbit-url.path;
        target_site = [
          {
            server._secret = config.sops.secrets.nemorosa_tracker1-url.path;
            api_key._secret = config.sops.secrets.nemorosa_tracker1-api.path;
          }
          {
            server._secret = config.sops.secrets.nemorosa_tracker2-url.path;
            api_key._secret = config.sops.secrets.nemorosa_tracker2-api.path;
          }
        ];
      };
    };

    systemd.services.nemorosa = {
      after = [ "qbittorrent.service" ];
      requires = [ "qbittorrent.service" ];
    };
  };
}
