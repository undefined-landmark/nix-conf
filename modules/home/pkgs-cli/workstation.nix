{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.pkgs-cli-workstation;
in {
  options.custom-home-modules.pkgs-cli-workstation = {
    enable = lib.mkEnableOption "cli applications for workstation (settings)";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.yubikey1_priv = {};
    sops.secrets.yubikey2_priv = {};
    sops.secrets.ssh_hosts = {};
    sops.secrets.ansible_portable_vault = {};

    home.packages = [
      pkgs.ansible
      pkgs.mediainfo
      pkgs.distrobox
      pkgs.R
      pkgs.pandoc
      pkgs.texliveSmall
      pkgs.smartmontools
      pkgs.zip
      pkgs.unzip
      pkgs.devenv
      pkgs.nixpkgs-review
    ];

    programs.ssh = {
      enable = true;
      matchBlocks."192.168.*" = {
        identityFile = [
          config.sops.secrets.yubikey1_priv.path
          config.sops.secrets.yubikey2_priv.path
        ];
      };
      includes = [config.sops.secrets.ssh_hosts.path];
      extraConfig = ''
      CanonicalizeHostname = yes
      '';
    };

    xdg.configFile.ansible-cfg = {
      target = "../.ansible.cfg";
      text = ''
        [defaults]
        vault_password_file = ${config.sops.secrets.ansible_portable_vault.path}
      '';
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig.XDG_MISC_DIR = "${config.home.homeDirectory}/git";
    };

    programs.mpv.enable = true;

    programs.gh.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
  };
}
