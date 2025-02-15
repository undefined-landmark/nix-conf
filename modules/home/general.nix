{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.general;
in {
  options.custom-home-modules.general = {
    enable = lib.mkEnableOption "Universal home-manager settings";
  };

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
    home.username = "bas";
    home.homeDirectory = "/home/bas";

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
      };
    };
  };
}
