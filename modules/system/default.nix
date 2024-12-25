{lib, ...}: {
  options.custom-modules = {
    enable = lib.mkEnableOption "Custom system modules";
  };
  imports = [
    ./x11.nix
    ./audio.nix
    ./nvidia.nix
    ./stylix.nix
    ./general.nix
    ./wg-quick.nix
    ./samba-mount.nix
  ];
}
