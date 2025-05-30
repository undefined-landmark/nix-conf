{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.pkgs-gui;
in {
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        "cursor_stop_blinking_after" = 0;
      };
    };
  };
}
