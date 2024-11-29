{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.sops-nix.homeManagerModules.sops
    ../../home/general.nix
    ../../home/pkgs-cli.nix
    ../../home/pkgs-gui.nix
    ../../home/i3.nix
    ../../home/nixvim.nix
    ../../home/autorandr.nix
    ../../home/sops.nix
  ];
}
