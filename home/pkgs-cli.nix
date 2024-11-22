{pkgs, ...}: {
  home.packages = [
    pkgs.alejandra
  ];

  programs.nh = {
    enable = true;
    clean.dates = "weekly";
    flake = "/home/bas/nix-conf";
  };
}
