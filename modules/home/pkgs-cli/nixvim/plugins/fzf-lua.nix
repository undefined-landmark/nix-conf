{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.pkgs-cli;
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
