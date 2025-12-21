{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.pkgs-gui;
in
{
  imports = [
    ./custom-bins
    ./firefox.nix
  ];

  options.myHome.pkgs-gui = {
    enable = lib.mkEnableOption "gui applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.darktable
      pkgs.digikam
      pkgs.mariadb
      pkgs.gimp3
      pkgs.fluffychat
      pkgs.halloy
      pkgs.kdePackages.kcalc
      pkgs.libreoffice-qt6-fresh
      pkgs.omnissa-horizon-client
      pkgs.picard
      pkgs.protonvpn-gui
      pkgs.signal-desktop
      pkgs.slack
      pkgs.spotify
      pkgs.zoom-us
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
