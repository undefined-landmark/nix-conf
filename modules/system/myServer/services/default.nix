{...}: {
  imports = [
    ./qbittorrent
    ./arr.nix
    ./crossSeed.nix
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
