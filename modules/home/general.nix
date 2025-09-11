{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.general;
  username = config.myHome.user;
in
{
  options.myHome.general = {
    enable = lib.mkEnableOption "Universal home-manager settings";
  };

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
    home.username = username;
    home.homeDirectory = "/home/${username}";

    nixpkgs.config.allowUnfree = true;

    programs.bash = {
      enable = true;
      bashrcExtra = # bash
        ''
          source ${pkgs.lf.src}/etc/lfcd.sh
          set -o vi
          nix-repos() {
            echo "nix-conf:"
            git -C ~/git/nix-conf "$1"
            echo "nix-secrets:"
            git -C ~/git/nix-secrets "$1"
          }
        '';
      shellAliases = {
        lf = "lfcd";
        nvimgit = "nvim +Git +only";
      };
    };
  };
}
