{pkgs, ...}: {
  home.packages = [
    pkgs.alejandra
    pkgs.tldr
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
    };
    flake = "/home/bas/nix-conf";
  };

  programs.git = {
    enable = true;
    userEmail = "bas@noemail.invalid";
    userName = "bas";
  };

  programs.btop.enable = true;
}
