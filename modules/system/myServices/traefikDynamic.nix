{
  lib,
  config,
  ...
}:
let
  cfg = config.myServices.traefik;
  genRouter =
    {
      domain ? config.myServices.baseDomain,
      subdomain,
      ...
    }:
    {
      "${subdomain}" = {
        service = subdomain;
        rule = "Host(`${subdomain}.${domain}`)";
      };
    };
  genService =
    {
      subdomain,
      port,
      ...
    }:
    {
      "${subdomain}".loadBalancer.servers = [ { url = "http://localhost:${port}"; } ];
    };
  routers = lib.mergeAttrsList (builtins.map genRouter cfg.params);
  services = lib.mergeAttrsList (builtins.map genService cfg.params);
in
{
  options.myServices.traefik.params = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf lib.types.str);
    description = ''
      List of attributesets containing parameters to generate
      traefik.paramsConfigOptions routers and services.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.traefik.dynamicConfigOptions.http.routers = routers;
    services.traefik.dynamicConfigOptions.http.services = services;
  };
}
