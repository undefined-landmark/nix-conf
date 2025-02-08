{lib, ...}: {
  imports = [
    ./x11.nix
    ./audio.nix
    ./nvidia.nix
    ./stylix.nix
    ./samba-mount.nix
  ];

  options.custom-modules.desktop-environment = {
    enable = lib.mkEnableOption "Desktop environment";
  };
}
