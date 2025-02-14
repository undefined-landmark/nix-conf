{lib, ...}: {
  options.custom-modules = {
    enable = lib.mkEnableOption "Custom system modules";
  };
  imports = [
    ./server
    ./workstation
    ./restic.nix
    ./general.nix
    ./wg-quick.nix
    ./private-vars.nix
  ];
}
