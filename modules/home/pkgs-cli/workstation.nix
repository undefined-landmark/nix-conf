{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.pkgs-cli-workstation;
in
{
  options.myHome.pkgs-cli-workstation = {
    enable = lib.mkEnableOption "cli applications for workstation (settings)";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.yubikey1_priv = { };
    sops.secrets.yubikey2_priv = { };
    sops.secrets.ssh_hosts = { };
    sops.secrets.ansible_portable_vault = { };

    home.packages = [
      pkgs.R
      pkgs.ansible
      pkgs.distrobox
      pkgs.flac
      pkgs.mediainfo
      pkgs.nixpkgs-review
      pkgs.pandoc
      pkgs.python313
      pkgs.smartmontools
      pkgs.unzip
      pkgs.zip
    ];

    programs.ssh = {
      enable = true;
      settings = {
        "Host 192.168.*" = {
          identityFile = [
            config.sops.secrets.yubikey2_priv.path
            config.sops.secrets.yubikey1_priv.path
          ];
          UpdateHostKeys = "no";
        };
        "Host *" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          CanonicalizeHostname = "yes";
        };
      };
      includes = [ config.sops.secrets.ssh_hosts.path ];
      enableDefaultConfig = false;
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
      extraConfig.MISC = "${config.home.homeDirectory}/git";
      setSessionVariables = false;
    };

    programs.mpv.enable = true;

    programs.gh.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    services.ssh-agent.enable = true;
  };
}
