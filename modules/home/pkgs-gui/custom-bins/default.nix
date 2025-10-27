{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.pkgs-gui;
  ss_sel = pkgs.writeShellScriptBin "ss_sel" (builtins.readFile ./ss_sel.sh);
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [ ss_sel ];
  };
}
