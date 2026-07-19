{
  lib,
  config,
  ...
}:
let
  cfg = config.myServer.remote-unlock;
in
{
  options.myServer.remote-unlock.enable = lib.mkEnableOption "Setup remote-unlock";

  config = lib.mkIf cfg.enable {
    boot = {
      kernelParams = [ "rd.systemd.debug_shell=1" ];
      initrd = {
        availableKernelModules = [ "e1000e" ];
        systemd.network = {
          enable = true;
          networks."10-eno1" = {
            matchConfig.Name = "eno1";
            networkConfig.DHCP = "ipv4";
            linkConfig.RequiredForOnline = "routable";
          };
        };
        network = {
          enable = true;
          ssh = {
            enable = true;
            port = 22;
            authorizedKeys = [
              ''command="systemctl default" ${config.my-secrets.private.vars.yubikey1_pub}''
              ''command="systemctl default" ${config.my-secrets.private.vars.yubikey2_pub}''
            ];
            hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
          };
        };
      };
    };
  };
}
