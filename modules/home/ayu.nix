{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome.ayu;
in {
  options.myHome.ayu = {
    enable = lib.mkEnableOption "ayu specific settings";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = config.my-secrets.private.vars.gh-email-ayu;
      userName = "ayu";
      extraConfig = {
        push.autoSetupRemote = true;
      };
    };

    programs.vscode.enable = true;

    home.packages = [
      pkgs.rstudio
      pkgs.texliveFull
    ];

  };
}
