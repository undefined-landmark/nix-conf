{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.mySys.stylix;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  options.mySys.stylix = {
    enable = lib.mkEnableOption "stylix setup";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../../dekmantel.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        sizes = {
          desktop = 14;
          popups = 14;
          applications = 14;
          terminal = 14;
        };
      };
    };
  };
}
