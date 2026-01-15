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
          sox-zoom() {
            ${pkgs.sox}/bin/sox "$1" -n remix 1 spectrogram -X 500 -y 1025 -z 120 -w Kaiser -S "$2" -d 0:02 -o "/tmp/sox-zoom.png"
          }
        '';
      shellAliases = {
        lf = "lfcd";
        nvimgit = "nvim +Git +only";
        grep_sample_bit = "grep -E \"Complete name|Bit depth|Sampling rate\"";
        flac_rm_img = "metaflac --dont-use-padding --remove --block-type=PICTURE,PADDING";
      };
    };
  };
}
