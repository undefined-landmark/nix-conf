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
            "<leader>ff" = "files";
            "<leader>fr" = "oldfiles";
            "<leader>fg" = "live_grep";
          };
        };
      };
    };
  };
}
