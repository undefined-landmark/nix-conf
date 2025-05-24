{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.general;
  username = config.custom-home-modules.user;
in {
  options.custom-home-modules.general = {
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
      bashrcExtra = ''
        source ${pkgs.lf.src}/etc/lfcd.sh
        set -o vi
      '';
      shellAliases = {
        lf = "lfcd";
        nvimgit = "nvim +Git +only";
        pull-nix-repos =
          /*
          bash
          */
          ''
            echo "nix-conf:"
            git -C ~/git/nix-conf pull
            echo "nix-secrets:"
            git -C ~/git/nix-secrets pull
          '';
        push-nix-repos =
          /*
          bash
          */
          ''
            echo "nix-conf:"
            git -C ~/git/nix-conf push
            echo "nix-secrets:"
            git -C ~/git/nix-secrets push
          '';
      };
    };
  };
}
