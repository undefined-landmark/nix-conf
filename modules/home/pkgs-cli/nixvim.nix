{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.myHome.pkgs-cli;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      diagnostic.settings = {
        virtual_lines.current_line = true;
        virtual_text = false;
      };
      globals = {
        netrw_banner = 0;
        mapleader = " ";
      };
      opts = {
        number = true;
        relativenumber = true;
        colorcolumn = "80";
        termguicolors = true;
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        smartindent = true;
        spell = true;
        spelllang = "nl,en";
      };
      plugins = {
        fugitive.enable = true;
        colorizer.enable = true;
        sleuth.enable = true;
        indent-blankline.enable = true;
        fzf-lua = {
          enable = true;
          keymaps = {
            "<leader>f" = "files";
            "<leader>g" = "live_grep";
          };
        };
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
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
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };
        lsp = {
          enable = true;
          keymaps.lspBuf = {
            df = "format";
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
          servers = {
            nixd = {
              enable = true;
              settings = {
                nixpkgs.expr = "import <nixpkgs> { }";
                formatting.command = [ "${lib.getExe pkgs.nixfmt}" ];
              };
            };
            statix.enable = true;
            bashls.enable = true;
            ts_ls.enable = true;
            ty.enable = true;
          };
        };
      };
    };
  };
}
