{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myServices.paperless;
  tikaPort = toString config.services.tika.port;
  gotenbergPort = toString config.services.gotenberg.port;
  paperlessPort = toString config.services.paperless.port;
in
{
  options.myServices.paperless.enable = lib.mkEnableOption "Setup paperless";

  config = lib.mkIf cfg.enable {
    sops.secrets.paperless-pass = { };

    services.paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      settings = {
        PAPERLESS_ADMIN_USER = "dexterous";
        PAPERLESS_URL = "https://paperless.${config.myServices.baseDomain}";

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
      ensureDatabases = [ "paperless" ];
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

    myServices.traefik.params = [
      {
        subdomain = "paperless";
        port = paperlessPort;
      }
    ];
  };
}
