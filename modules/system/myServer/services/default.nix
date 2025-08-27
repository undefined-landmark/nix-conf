{...}: {
  imports = [
    ./arr.nix
    ./calibre-server.nix
    ./crossSeed.nix
    ./homepage.nix
    ./jellyfin.nix
    ./paperless.nix
    ./prometheus_grafana.nix
    ./qbittorrent
    ./resticServer.nix
    ./samba.nix
    ./scrutiny.nix
    ./tandoor.nix
    ./traefik.nix
    ./traefikDynamic.nix
  ];
}
