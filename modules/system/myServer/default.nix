{lib, ...}: {
  imports = [
    ./misc.nix
    ./postgresqlBackup.nix
    ./remote-unlock.nix
    ./ssh.nix
  ];

  options.myServer = {
    enable = lib.mkEnableOption "Server setup";
  };
}
