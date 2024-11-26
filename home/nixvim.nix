{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    globals.netrw_banner = 0;
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
      nvim-colorizer.enable = true;
      lsp = {
        enable = true;
        keymaps.lspBuf = {
          df = "format";
        };
        servers = {
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = ["alejandra"];
              options.nixos.expr = "(builtins.getFlake \"/home/bas/nix-conf\").nixosConfigurations.lightbox.options";
              options.home_manager.expr = "(import <home-manager/modules> { configuration = /home/bas/nix-conf/hosts/lightbox/home.nix; pkgs = import <nixpkgs> {}; }).options";
            };
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
    };
  };
}
