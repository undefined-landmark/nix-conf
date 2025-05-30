{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome.pkgs-gui;
in {
  imports = [
    ./kitty.nix
    ./firefox.nix
    ./custom-bins
  ];

  options.myHome.pkgs-gui = {
    enable = lib.mkEnableOption "gui applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zoom-us
      pkgs.spotify
      pkgs.vmware-horizon-client
      pkgs.halloy
      pkgs.signal-desktop
      pkgs.slack
      pkgs.libreoffice-qt6-fresh
      pkgs.rstudio
      pkgs.kdePackages.kcalc
    ];

    programs.zathura = {
      enable = true;
      options = {
        "selection-clipboard" = "clipboard";
      };
    };

    programs.feh.enable = true;
  };
}
