{pkgs, ...}: {
  programs.firefox = {
    enable = true;
  };

  home.packages = [
    pkgs.zoom-us
    pkgs.spotify
    pkgs.vmware-horizon-client
    pkgs.halloy
    pkgs.pavucontrol
    pkgs.xfce.xfce4-power-manager
  ];

  services.network-manager-applet.enable = true;
  services.udiskie = {
    enable = true;
    tray = "always";
  };
}
