{...}: {
  imports = [
    ./qbittorrent
    ./arr.nix
    ./samba.nix
    ./traefik.nix
    ./jellyfin.nix
    ./scrutiny.nix
    ./traefikDynamic.nix
  ];
}
