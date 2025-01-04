{lib, ...}: {
  options.custom-modules = {
    enable = lib.mkEnableOption "Custom system modules";
  };
  imports = [
    ./server
    ./x11.nix
    ./audio.nix
    ./nvidia.nix
    ./restic.nix
    ./stylix.nix
    ./general.nix
    ./wg-quick.nix
    ./samba-mount.nix
  ];
}
