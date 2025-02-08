{lib, ...}: {
  imports = [
    ./ssh.nix
    ./misc.nix
    ./samba.nix
    ./remote-unlock.nix
  ];

  options.custom-modules.server = {
    enable = lib.mkEnableOption "Server setup";
  };
}
