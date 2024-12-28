{pkgs, ...}: let
  ss_sel =
    pkgs.writeShellScriptBin
    "ss_sel"
    (builtins.readFile ./ss_sel.sh);
in {
  home.packages = [
    ss_sel
  ];
}
