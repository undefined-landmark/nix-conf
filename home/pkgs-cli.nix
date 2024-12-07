{
  pkgs,
  config,
  ...
}: {
  sops.secrets.yubikey1_priv = {};
  sops.secrets.yubikey2_priv = {};
  sops.secrets.ssh_hosts = {};
  sops.secrets.ansible_portable_vault = {};

  home.packages = [
    pkgs.alejandra
    pkgs.tldr
    pkgs.ansible
    pkgs.mediainfo
    pkgs.trash-cli
    pkgs.distrobox
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
    };
    flake = "/home/bas/git/nix-conf";
  };

  programs.git = {
    enable = true;
    userEmail = "bas@noemail.invalid";
    userName = "bas";
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };

  programs.btop.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.lf = {
    enable = true;
    settings = {
      hiddenfiles = ".*:!.config";
      shell = "bash";
      shellopts = "-eu";
    };
    keybindings = {
      "<enter>" = "shell";
      a = ":push %mkdir<space>";
      "`" = "!true";
      gm = "cd /mnt/";
      gu = "cd /run/media/bas/";
    };
    commands = {
      z = ''
        %{{
        result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
        }}
      '';
      zi = ''
        ''${{
        result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
        }}
      '';
      on-cd = ''
        &{{
        zoxide add "$PWD"
        }}
      '';
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks."192.168.*" = {
      identityFile = [
        config.sops.secrets.yubikey1_priv.path
        config.sops.secrets.yubikey2_priv.path
      ];
    };
    includes = [config.sops.secrets.ssh_hosts.path];
    extraConfig = "CanonicalizeHostname = yes";
  };

  xdg.configFile.ansible-cfg = {
    target = "../.ansible.cfg";
    text = ''
      [defaults]
      vault_password_file = ${config.sops.secrets.ansible_portable_vault.path}
    '';
  };

  services.podman.enable = true;
}
