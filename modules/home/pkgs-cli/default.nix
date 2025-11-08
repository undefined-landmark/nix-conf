{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.myHome.pkgs-cli;
in
{
  imports = [
    ./nixvim
    ./lf.nix
    ./workstation.nix
    inputs.my-secrets.uploadTools
  ];

  options.myHome.pkgs-cli = {
    enable = lib.mkEnableOption "cli applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tldr
      pkgs.trash-cli
      pkgs.shellcheck
      pkgs.sops
      # So that ecobox recognizes xterm-kitty
      pkgs.kitty
    ];

    my-secrets.uploadTools.enable = true;

    programs.btop.enable = true;

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
