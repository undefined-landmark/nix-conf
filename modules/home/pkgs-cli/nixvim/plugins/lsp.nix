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
                #                options.nixos.expr = "(builtins.getFlake \"/home/bas/git/nix-conf\").nixosConfigurations.lightbox.options";
                #                options.home_manager.expr = "(import <home-manager/modules> { configuration = /home/bas/git/nix-conf/hosts/lightbox/home.nix; pkgs = import <nixpkgs> {}; }).options";
              };
            };
            bashls.enable = true;
          };
        };
      };
    };
  };
}
