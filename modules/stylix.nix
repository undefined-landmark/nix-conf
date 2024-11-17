{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    image = ../dekmantel.jpg;
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
    };
  };
}
