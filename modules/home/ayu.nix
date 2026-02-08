{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.ayu;
in
{
  options.myHome.ayu = {
    enable = lib.mkEnableOption "ayu specific settings";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = config.my-secrets.private.vars.gh-email-ayu;
          name = "ayu";
        };
        push.autoSetupRemote = true;
      };
    };

    home.packages = [
      pkgs.rstudio
      pkgs.texliveFull
    ];

  };
}
