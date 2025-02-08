{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  imports = [../sops.nix];

  config = lib.mkIf cfg.enable {
    custom-modules.sops.enable = true;
    sops.secrets.yubikey1_pub = {};
    sops.secrets.yubikey2_pub = {};

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PubkeyAuthentication = true;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        ClientAliveInterval = 300;
        X11Forwarding = false;

        # Disable non-used authentication methods
        ChallengeResponseAuthentication = false;
        KerberosAuthentication = false;
        GSSAPIAuthentication = false;
      };
    };

    users.users.bas = {
      openssh.authorizedKeys.keyFiles = [
        config.sops.secrets.yubikey1_pub.path
        config.sops.secrets.yubikey2_pub.path
      ];
    };
  };
}
