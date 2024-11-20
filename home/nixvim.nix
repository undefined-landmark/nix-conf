{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
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
              nixpkgs.expr = "import nixpkgs { }";
              formatting.command = ["alejandra"];
              options.nixos.expr = "(builtins.getFlake \"/home/bas/nix-conf/flake.nix\").nixosConfigurations.nixvm.options";
            };
          };
        };
      };
      fugitive.enable = true;
    };
  };
}
