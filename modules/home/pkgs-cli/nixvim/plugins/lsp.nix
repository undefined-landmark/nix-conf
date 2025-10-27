{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.pkgs-cli;
in
{
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
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
                formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
            };
            statix.enable = true;
            bashls.enable = true;
          };
        };
      };
    };
  };
}
