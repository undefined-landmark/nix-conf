{lib, ...}: {
  options.custom-home-modules = {
    enable = lib.mkEnableOption "Custom home-manager modules";
  };
  imports = [
    ./i3.nix
    ./general.nix
    ./pkgs-cli
    ./pkgs-gui
    ./autorandr.nix
  ];
}
