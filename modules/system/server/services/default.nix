{...}: {
  imports = [
    ./qbittorrent
    ./arr.nix
    ./samba.nix
    ./traefik.nix
    ./jellyfin.nix
    ./scrutiny.nix
    ./homepage.nix
    ./resticServer.nix
    ./traefikDynamic.nix
    ./paperless.nix
    ./tandoor.nix
  ];
}
