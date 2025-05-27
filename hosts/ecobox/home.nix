{...}: {
  imports = [../../modules/home];

  custom-home-modules = {
    enable = true;
    user = "bas";
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };
}
