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
      pkgs.alejandra
      pkgs.tldr
      pkgs.trash-cli
      pkgs.shellcheck
      pkgs.sops
      # So that ecobox recognizes xterm-kitty
      pkgs.kitty
    ];

    programs.git = {
      enable = true;
      userEmail = config.my-secrets.private.vars.gh-email;
      userName = "bas";
      extraConfig = {
        push.autoSetupRemote = true;
      };
    };

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
