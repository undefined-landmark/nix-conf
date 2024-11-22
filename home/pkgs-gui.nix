{pkgs, ...}: {
  programs.firefox = {
    enable = true;
  };

  home.packages = [
    pkgs.zoom-us
    pkgs.spotify
    pkgs.vmware-horizon-client
    pkgs.halloy
  ];
}
