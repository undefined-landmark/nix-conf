{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome.general;
  username = config.myHome.user;
  nix_repos_action = action:
  /*
  bash
  */
  ''
    echo "nix-conf:"
    git -C ~/git/nix-conf ${action}
    echo "nix-secrets:"
    git -C ~/git/nix-secrets ${action}
  '';
in {
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
      bashrcExtra = ''
        source ${pkgs.lf.src}/etc/lfcd.sh
        set -o vi
      '';
      shellAliases = {
        lf = "lfcd";
        nvimgit = "nvim +Git +only";
        pull-nix-repos = nix_repos_action "pull";
        push-nix-repos = nix_repos_action "push";
      };
    };
  };
}
