{...}: {
  imports = [
    ./arr
    ./qbittorrent
    ./samba.nix
    ./traefik.nix
    ./jellyfin.nix
    ./scrutiny.nix
    ./traefikDynamic.nix
    ./paperless.nix
  ];
}
