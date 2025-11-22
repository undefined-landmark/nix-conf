{ ... }:
{
  imports = [ ../../modules/home ];

  myHome = {
    enable = true;
    user = "bas";
    bas.enable = true;
    sops = {
      enable = true;
      sepHomeDrive = true;
    };
    general.enable = true;
    pkgs-cli = {
      enable = true;
      uploadTools = true;
    };
    pkgs-cli-workstation.enable = true;
    pkgs-gui.enable = true;
  };

}
