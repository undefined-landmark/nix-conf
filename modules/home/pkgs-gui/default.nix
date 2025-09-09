{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  ...
}: let
  cfg = config.myHome.pkgs-gui;
in {
  imports = [
    ./custom-bins
    ./firefox.nix
  ];

  options.myHome.pkgs-gui = {
    enable = lib.mkEnableOption "gui applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zoom-us
      pkgs.spotify
      pkgsUnstable.omnissa-horizon-client
      pkgs.halloy
      pkgs.signal-desktop
      pkgs.slack
      pkgs.libreoffice-qt6-fresh
      pkgs.kdePackages.kcalc
      pkgs.darktable
      pkgs.gimp3
    ];

    programs = {
      zathura = {
        enable = true;
        options = {
          "selection-clipboard" = "clipboard";
        };
      };

      feh.enable = true;

      kitty = {
        enable = true;
        settings = {
          "cursor_stop_blinking_after" = 0;
        };
      };
    };
  };
}
