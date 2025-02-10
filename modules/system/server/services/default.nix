{...}: {
  imports = [
    ./samba.nix
    ./traefik.nix
    ./jellyfin.nix
    ./qbittorrent.nix
  ];
}
