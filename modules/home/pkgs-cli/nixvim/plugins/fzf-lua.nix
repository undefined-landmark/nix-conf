{
  lib,
  config,
  ...
}: let
  cfg = config.custom-home-modules.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        fzf-lua = {
          enable = true;
          keymaps = {
            "<C-p>" = "oldfiles";
          };
        };
      };
    };
  };
}
