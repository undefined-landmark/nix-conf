{ inputs, pkgs, ... }:
let
  mountAndBackup = pkgs.writeShellApplication {
    name = "mountAndBackup";
    text = builtins.readFile ./mountAndBackup.sh;
  };
in
{
  imports = [
    ../../modules/home
    inputs.my-secrets.uploadTools
  ];

  myHome = {
    enable = true;
    user = "bas";
    bas.enable = true;
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };

  my-secrets.uploadTools.enable = true;

  home.packages = [ mountAndBackup ];
}
