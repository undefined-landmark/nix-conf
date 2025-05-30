{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome.pkgs-cli;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            bash
            python
            nix
            markdown
            json
            lua
            regex
            toml
            yaml
          ];
        };
      };
    };
  };
}
