{lib, ...}: {
  options.custom-home-modules = {
    enable = lib.mkEnableOption "Custom home-manager modules";
  };
  imports = [
    ./i3.nix
    ./nixvim.nix
    ./general.nix
    ./pkgs-cli.nix
    ./pkgs-gui.nix
    ./autorandr.nix
  ];
}
