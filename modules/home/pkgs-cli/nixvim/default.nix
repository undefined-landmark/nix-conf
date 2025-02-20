{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-cli;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins
  ];

  config = lib.mkIf cfg.enable {
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
    };
  };
}
