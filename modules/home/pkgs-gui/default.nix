{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-gui;
in {
  imports = [
    ./kitty.nix
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
      pkgs.signal-desktop
      pkgs.slack
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
