{lib, ...}: {
  imports = [
    ./audio.nix
    ./x11.nix
    ./printing.nix
  ];

  options.myDE.i3 = {
    enable = lib.mkEnableOption "Setup i3";
  };
}
