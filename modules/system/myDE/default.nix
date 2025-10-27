{ lib, ... }:
{
  imports = [
    ./i3
    ./gnome.nix
    ./kde.nix
    ./samba-mount.nix
  ];

  options.myDE = {
    enable = lib.mkEnableOption "General DE settings";
  };
}
