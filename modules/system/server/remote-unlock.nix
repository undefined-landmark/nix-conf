{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.server;
in {
  config = lib.mkIf cfg.enable {
    boot.initrd = {
      availableKernelModules = ["e1000e"];
      network = {
        enable = true;
        udhcpc.enable = true;
        flushBeforeStage2 = true;
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = [
            config.my-secrets.private.vars.yubikey1_pub
            config.my-secrets.private.vars.yubikey2_pub
          ];
          hostKeys = ["/etc/secrets/initrd/ssh_host_ed25519_key"];
        };
        postCommands = ''
          echo 'cryptsetup-askpass || echo "Unlock was succesful; exiting SSH session" && exit 1' >> /root/.profile
        '';
      };
    };
  };
}
