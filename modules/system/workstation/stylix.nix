{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  imports = [inputs.stylix.nixosModules.stylix];

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../../dekmantel.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
      fonts = {
        monospace = {
          package = pkgs.fira-code-nerdfont;
          name = "FiraCode Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
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
