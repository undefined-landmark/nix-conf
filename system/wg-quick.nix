{config, ...}: {
  sops.secrets.lightbox-wg-east = {};
  sops.secrets.lightbox-wg-west = {};
  sops.secrets.lightbox-wg-proton = {};

  networking.wg-quick.interfaces = {
    east = {
      configFile = config.sops.secrets.lightbox-wg-east.path;
      autostart = false;
    };
    west = {
      configFile = config.sops.secrets.lightbox-wg-west.path;
      autostart = false;
    };
    proton = {
      configFile = config.sops.secrets.lightbox-wg-proton.path;
      autostart = false;
    };
  };
}
