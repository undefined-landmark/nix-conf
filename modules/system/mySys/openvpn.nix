{
  lib,
  config,
  ...
}:
let
  cfg = config.mySys.openvpn;
in
{
  options.mySys.openvpn = {
    enable = lib.mkEnableOption "openvpn setup";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.openvpnauth = { };

    services.openvpn.servers = {
      infra = {
        config = "config /home/bas/Documents/openvpn.conf";
      };
    };
  };
}
