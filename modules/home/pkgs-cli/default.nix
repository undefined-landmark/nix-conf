{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome.pkgs-cli;
in {
  imports = [
    ./nixvim
    ./lf.nix
    ./workstation.nix
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
