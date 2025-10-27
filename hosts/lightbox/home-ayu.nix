{ ... }:
{
  imports = [ ../../modules/home ];

  myHome = {
    enable = true;
    user = "ayu";
    ayu.enable = true;
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-cli-workstation.enable = true;
    pkgs-gui.enable = true;
  };
}
