{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.wg-quick;
  sopsCfg = config.sops.secrets;

  wgSecrets = {
    lightbox = {
      lightbox-wg-east = {};
      lightbox-wg-west = {};
      lightbox-wg-proton = {};
    };
    ecobox = {
      ecobox-wg-protonfw = {};
    };
  };

  wgInterfaces = {
    lightbox = {
      east = {
        configFile = sopsCfg.lightbox-wg-east.path;
        autostart = false;
      };
      west = {
        configFile = sopsCfg.lightbox-wg-west.path;
        autostart = false;
      };
      proton = {
        configFile = sopsCfg.lightbox-wg-proton.path;
        autostart = true;
      };
    };
    ecobox = {
      protonfw = {
        configFile = sopsCfg.ecobox-wg-protonfw.path;
        autostart = true;
      };
    };
  };
in {
  options.custom-modules.wg-quick = {
    enable = lib.mkEnableOption "wg-quick setup";
    hostname = lib.mkOption {
      type = lib.types.str;
      description = ''
        Hostname of the machine where the wireguard configurations will be set.
        The configurations are different per host and do not need to be available for every host.
        Therefore the configs of only the give hostname are applied.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = lib.getAttr cfg.hostname wgSecrets;
    networking.wg-quick.interfaces = lib.getAttr cfg.hostname wgInterfaces;

    networking.firewall.interfaces.protonfw = lib.mkIf (cfg.hostname == "ecobox") {
      allowedUDPPortRanges = [
        {
          from = 40000;
          to = 65535;
        }
      ];
      allowedTCPPortRanges = [
        {
          from = 40000;
          to = 65535;
        }
      ];
    };
  };
}
