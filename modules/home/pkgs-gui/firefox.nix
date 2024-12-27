{
  lib,
  config,
  ...
}: let
  cfg = config.custom-home-modules.firefox;
in {
  options.custom-home-modules.firefox = {
    enable = lib.mkEnableOption "firefox with policies";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        Extensions = {
          Install = [
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/cookie-autodelete/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/vimium-FF/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/woordenboek-nederlands/latest.xpi"
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
