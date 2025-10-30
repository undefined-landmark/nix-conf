{ inputs, ... }:
{
  imports = [
    ../../modules/home
    inputs.my-secrets.uploadTools
  ];

  myHome = {
    enable = true;
    user = "bas";
    bas.enable = true;
    sops = {
      enable = true;
      sepHomeDrive = true;
    };
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-cli-workstation.enable = true;
    pkgs-gui.enable = true;
  };

  my-secrets.uploadTools.enable = true;
}
