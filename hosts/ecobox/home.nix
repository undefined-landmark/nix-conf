{...}: {
  imports = [../../modules/home];

  custom-home-modules = {
    enable = true;
    user = "bas";
    general.enable = true;
    pkgs-cli.enable = true;
  };
}
