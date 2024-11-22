{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.username = "bas";
  home.homeDirectory = "/home/bas";

  nixpkgs.config.allowUnfree = true;
  programs.bash.enable = true;
}
