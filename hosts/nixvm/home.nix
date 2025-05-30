{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [../../modules/home];

  myHome = {
    enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };
}
