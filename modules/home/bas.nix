{
  lib,
  config,
  ...
}:
let
  cfg = config.myHome.bas;
in
{
  options.myHome.bas = {
    enable = lib.mkEnableOption "bas specific settings";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = config.my-secrets.private.vars.gh-email;
      userName = "bas";
      extraConfig = {
        push.autoSetupRemote = true;
      };
    };
  };
}
