{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myServer.wireguard;
  wgPort = config.networking.wireguard.interfaces.wg0.listenPort;
  ipBase = "10.100.0";
  extInterface = "eth0";
  intInterface = "wg0";
  forwardLines = switch: ''
    ${pkgs.iptables}/bin/iptables ${switch} FORWARD -i ${intInterface} -j ACCEPT
    ${pkgs.iptables}/bin/iptables ${switch} FORWARD -o ${intInterface} -j ACCEPT
  '';
  postRouting = switch: ''
    ${pkgs.iptables}/bin/iptables -t nat ${switch} POSTROUTING -s ${ipBase}.0/24 -o ${extInterface} -j MASQUERADE
  '';
in
{
  options.myServer.wireguard.enable = lib.mkEnableOption "Setup wireguard server";

  config = lib.mkIf cfg.enable {
    sops.secrets.ecobox_wg-priv = { };

    networking = {
      nat = {
        enable = true;
        externalInterface = extInterface;
        internalInterfaces = [ intInterface ];
      };

      firewall.allowedUDPPorts = [ wgPort ];

      wireguard.interfaces.wg0 = {
        # Determines the IP address and subnet of the server's end of the tunnel interface.
        ips = [ "${ipBase}.1/24" ];
        listenPort = 51820;

        postSetup = ''
          ${forwardLines "-A"}
          ${postRouting "-A"}
        '';
        postShutdown = ''
          ${forwardLines "-D"}
          ${postRouting "-D"}
        '';

        privateKeyFile = config.sops.secrets.ecobox_wg-priv.path;

        peers = [
          {
            name = "phone";
            publicKey = "PC3HyEgaifOjnJ0Y30zx32cRpb6HHNE227dM8QPrJlA=";
            allowedIPs = [ "${ipBase}.2/32" ];
          }
          {
            name = "laptop";
            publicKey = "npTrLwAIJZ3m4XqdmQpP/KIi0C6urjBQHoCuA1vOOTc=";
            allowedIPs = [ "${ipBase}.3/32" ];
          }
        ];
      };
    };
  };
}
