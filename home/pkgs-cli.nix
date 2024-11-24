{pkgs, ...}: {
  home.packages = [
    pkgs.alejandra
  ];

  programs.nh = {
    enable = true;
    clean.dates = "weekly";
    flake = "/home/bas/nix-conf";
  };

  programs.git = {
    enable = true;
    userEmail = "bas@noemail.invalid";
    userName = "bas";
  };
}
