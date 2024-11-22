{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../home/i3.nix
    ../../home/nixvim.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.username = "bas";
  home.homeDirectory = "/home/bas";

  nixpkgs.config.allowUnfree = true;
  home.packages = [
    pkgs.alejandra
    pkgs.zoom-us
    pkgs.spotify
    pkgs.vmware-horizon-client
    pkgs.halloy
  ];

  programs.firefox = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.dates = "weekly";
    flake = "/home/bas/nix-conf";
  };

  programs.bash.enable = true;
}
