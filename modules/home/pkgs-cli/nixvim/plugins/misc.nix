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
        nvim-colorizer.enable = true;
      };
    };
  };
}
