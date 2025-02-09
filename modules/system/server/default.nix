{lib, ...}: {
  imports = [
    ./services
    ./ssh.nix
    ./misc.nix
    ./remote-unlock.nix
  ];

  options.custom-modules.server = {
    enable = lib.mkEnableOption "Server setup";
  };
}
