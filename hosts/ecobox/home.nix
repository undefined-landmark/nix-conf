{...}: {
  imports = [../../modules/home];

  myHome = {
    enable = true;
    user = "bas";
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };
}
