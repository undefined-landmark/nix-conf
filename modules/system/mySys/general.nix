{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mySys.general;
in
{
  options.mySys.general = {
    enable = lib.mkEnableOption "General setting";
  };

  config = lib.mkIf cfg.enable {
    system.stateVersion = "25.05";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Amsterdam";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };
    };

    users.users.bas = {
      isNormalUser = true;
      description = "bas";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    environment.systemPackages = [
      pkgs.git
      pkgs.neovim
      pkgs.lf
    ];

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 10";
      };
      flake = "/home/bas/git/nix-conf";
    };

    security.sudo.extraConfig = ''
      Defaults env_keep += "EDITOR"
    '';
  };
}
