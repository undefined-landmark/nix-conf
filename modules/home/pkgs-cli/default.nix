{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-cli;
in {
  imports = [
    ./lf.nix
    ./nixvim.nix
    ./workstation.nix
  ];

  options.custom-home-modules.pkgs-cli = {
    enable = lib.mkEnableOption "cli applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    custom-home-modules.lf.enable = true;
    custom-home-modules.nixvim.enable = true;

    home.packages = [
      pkgs.alejandra
      pkgs.tldr
      pkgs.trash-cli
      pkgs.shellcheck
    ];

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
      };
      flake = "/home/bas/git/nix-conf";
    };

    programs.git = {
      enable = true;
      userEmail = "bas@noemail.invalid";
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
  };
}
