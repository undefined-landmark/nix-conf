{
  lib,
  config,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-cli;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        fugitive.enable = true;
        colorizer.enable = true;
        sleuth.enable = true;
        indent-blankline.enable = true;
      };
    };
  };
}
