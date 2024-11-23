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
    ../../home/nixvim.nix
  ];
}
