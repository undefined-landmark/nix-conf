{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home
  ];

  custom-home-modules = {
    enable = true;
    i3.enable = true;
    sops.enable = true;
    nixvim.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-gui.enable = true;
    autorandr.enable = true;
  };
}
