{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [../../modules/home];

  custom-home-modules = {
    enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };
}
