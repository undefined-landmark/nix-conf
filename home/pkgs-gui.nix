{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    policies = {
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/cookie-autodelete/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/vimium-FF/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/woordenboek-nederlands/latest.xpi"
        ];
      };
      Homepage = {
        URL = "https://archlinux.org/";
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
      };
      OfferToSaveLoginsDefault = false;
      DisableTelemetry = true;
      SearchSuggestEnabled = false;
      DisplayBookmarksToolbar = "never";
      DisablePocket = true;
      PromptForDownloadLocation = true;
    };
    #    profiles.default.bookmarks = [
    #      {
    #        name = "test";
    #        toolbar = true;
    #        bookmarks = [
    #          {
    #            name = "test";
    #            url = "https://www.google.com";
    #          }
    #        ];
    #      }
    #    ];
  };

  home.packages = [
    pkgs.zoom-us
    pkgs.spotify
    pkgs.vmware-horizon-client
    pkgs.halloy
    pkgs.pavucontrol
    pkgs.xfce.xfce4-power-manager
    pkgs.signal-desktop
  ];

  services.network-manager-applet.enable = true;

  services.udiskie = {
    enable = true;
    tray = "always";
  };

  programs.zathura = {
    enable = true;
    options = {
      "selection-clipboard" = "clipboard";
    };
  };

  programs.feh.enable = true;
}
