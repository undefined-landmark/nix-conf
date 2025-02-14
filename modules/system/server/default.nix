{lib, ...}: {
  imports = [
    ./services
    ./ssh.nix
    ./misc.nix
    ./remote-unlock.nix
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
  };
}
