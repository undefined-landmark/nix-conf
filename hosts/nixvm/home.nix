{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../home/general.nix
    ../../home/pkgs-cli.nix
    ../../home/pkgs-gui.nix
    ../../home/i3.nix
    ../../home/nixvim.nix
  ];
}
