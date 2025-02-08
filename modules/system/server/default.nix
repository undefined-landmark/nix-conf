{lib, ...}: {
  imports = [
    ./ssh.nix
    ./misc.nix
    ./samba.nix
  ];

  options.custom-modules.server = {
    enable = lib.mkEnableOption "Server setup";
  };
}
