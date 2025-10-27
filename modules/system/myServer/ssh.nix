{
  lib,
  config,
  ...
}:
let
  cfg = config.myServer.ssh;
in
{
  options.myServer.ssh.enable = lib.mkEnableOption "Setup ssh";

  config = lib.mkIf cfg.enable {
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
      openssh.authorizedKeys.keys = [
        config.my-secrets.private.vars.yubikey1_pub
        config.my-secrets.private.vars.yubikey2_pub
      ];
    };
  };
}
