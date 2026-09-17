{ lib, ... }:
{
  imports = [
    ./kde.nix
    ./samba-mount.nix
  ];

  options.myDE = {
    enable = lib.mkEnableOption "General DE settings";
  };
}
