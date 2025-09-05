{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myServices;
  tikaPort = toString config.services.tika.port;
  gotenbergPort = toString config.services.gotenberg.port;
  paperlessPort = toString config.services.paperless.port;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.paperless-pass = {
      mode = "0440";
      owner = config.services.paperless.user;
      group = config.services.paperless.user;
    };

    services.paperless = {
      enable = true;
      package = pkgs.paperless-ngx.overrideAttrs (oldAttrs: {
        # These slow down the build a lot I believe
        doCheck = false;
      });
      settings = {
        PAPERLESS_ADMIN_USER = "dexterous";

        PAPERLESS_OCR_LANGUAGES = "nld";
        PAPERLESS_SECRET_KEY = config.my-secrets.private.vars.paperlessSecret;
        PAPERLESS_TIME_ZONE = "Europe/Amsterdam";
        PAPERLESS_OCR_LANGUAGE = "nld";

        PAPERLESS_DBHOST = "/run/postgresql";
        PAPERLESS_TIKA_ENABLED = "1";
        PAPERLESS_TIKA_ENDPOINT = "http://localhost:${tikaPort}";
        PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://localhost:${gotenbergPort}";
      };
      passwordFile = config.sops.secrets.paperless-pass.path;
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = ["paperless"];
      ensureUsers = [
        {
          name = "paperless";
          ensureDBOwnership = true;
        }
      ];
    };

    services.tika.enable = true;

    services.gotenberg = {
      enable = true;
      chromium.disableJavascript = true;
    };

    myServices.traefikDynamic = [
      {
        subdomain = "paperless";
        port = paperlessPort;
      }
    ];
  };
}
