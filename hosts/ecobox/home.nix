{ inputs, pkgs, ... }:
let
  mountAndBackup = pkgs.writeShellApplication {
    name = "mountAndBackup";
    text = builtins.readFile ./mountAndBackup.sh;
  };
in
{
  imports = [
    inputs.my-secrets.uploadTools
    ../../modules/home
  ];

  myHome = {
    enable = true;
    user = "bas";
    bas.enable = true;
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };

  my-secrets.uploadTools = {
    enable = true;
    full = false;
  };

  home.packages = [ mountAndBackup ];
}
