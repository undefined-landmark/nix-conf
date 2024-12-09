{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [../../modules/home];

  custom-home-modules = {
    enable = true;
    i3.enable = true;
    nixvim.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-gui.enable = true;
    autorandr.enable = true;
  };
}
