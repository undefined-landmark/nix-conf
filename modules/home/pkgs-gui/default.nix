{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-gui;
in {
  imports = [
    ./firefox.nix
    ./custom-bins
  ];

  options.custom-home-modules.pkgs-gui = {
    enable = lib.mkEnableOption "gui applications (settings)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zoom-us
      pkgs.spotify
      pkgs.vmware-horizon-client
      pkgs.halloy
      pkgs.pavucontrol
      pkgs.xfce.xfce4-power-manager
      pkgs.signal-desktop
      pkgs.shotgun
      pkgs.slop
      pkgs.slack
    ];

    services.network-manager-applet.enable = true;

    services.udiskie = {
      enable = true;
      tray = "always";
    };

    programs.zathura = {
      enable = true;
      options = {
        "selection-clipboard" = "clipboard";
      };
    };

    programs.feh.enable = true;
  };
}
