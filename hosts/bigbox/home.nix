{...}: {
  imports = [../../modules/home];

  custom-home-modules = {
    enable = true;
    user = "bas";
    i3.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-cli-workstation.enable = true;
    pkgs-gui.enable = true;
  };
}
