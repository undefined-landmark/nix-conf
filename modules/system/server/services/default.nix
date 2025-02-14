{...}: {
  imports = [
    ./qbittorrent
    ./samba.nix
    ./traefik.nix
    ./jellyfin.nix
  ];
}
