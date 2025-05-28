{lib, ...}: {
  imports = [
    ./misc.nix
    ./postgresqlBackup.nix
    ./remote-unlock.nix
    ./services
    ./ssh.nix
  ];

  options.custom-modules.server = {
    enable = lib.mkEnableOption "Server setup";
    mediagroup = lib.mkOption {
      type = lib.types.str;
      description = "Group that should be used to run media related applications";
    };
    baseDomain = lib.mkOption {
      type = lib.types.str;
      description = "Domain name that should be used for the reverse proxy";
    };
    traefikDynamic = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      description = ''
        List of attributesets containing parameters to generate traefikDynamicConfigOptions routers en services.
      '';
    };
  };
}
