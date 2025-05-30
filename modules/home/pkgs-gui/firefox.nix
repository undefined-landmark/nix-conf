{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.pkgs-gui;
  ffExtBaseUrl = "https://addons.mozilla.org/firefox/downloads/latest";
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        Extensions = {
          Install = [
            "${ffExtBaseUrl}/bitwarden-password-manager/latest.xpi"
            "${ffExtBaseUrl}/ublock-origin/latest.xpi"
            "${ffExtBaseUrl}/cookie-autodelete/latest.xpi"
            "${ffExtBaseUrl}/vimium-FF/latest.xpi"
            "${ffExtBaseUrl}/woordenboek-nederlands/latest.xpi"
          ];
        };
        Homepage = {
          URL = "https://archlinux.org/";
        };
        ManagedBookmarks = [
          {toplevel_name = "managed";}
          {
            name = "test";
            children = [
              {
                name = "Qwerty";
                url = "https://qwerty.kaiyi.cool/";
              }
              {
                name = "Monkeytype";
                url = "https://monkeytype.com/";
              }
            ];
          }
        ];
        EnableTrackingProtection = {
          Value = true;
          Locked = false;
          Cryptomining = true;
          Fingerprinting = true;
        };
        OfferToSaveLoginsDefault = false;
        DisableTelemetry = true;
        SearchSuggestEnabled = false;
        DisplayBookmarksToolbar = "never";
        DisablePocket = true;
        PromptForDownloadLocation = true;
      };
    };
  };
}
