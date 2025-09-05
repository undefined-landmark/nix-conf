{
  lib,
  config,
  ...
}: let
  cfg = config.myServices;
  genRouter = {
    domain ? cfg.baseDomain,
    subdomain,
    ...
  }: {
    "${subdomain}" = {
      service = subdomain;
      rule = "Host(`${subdomain}.${domain}`)";
    };
  };
  genService = {
    subdomain,
    port,
    ...
  }: {
    "${subdomain}".loadBalancer.servers = [{url = "http://localhost:${port}";}];
  };
  routers = lib.mergeAttrsList (builtins.map genRouter cfg.traefikDynamic);
  services = lib.mergeAttrsList (builtins.map genService cfg.traefikDynamic);
in {
  config = lib.mkIf cfg.enable {
    services.traefik.dynamicConfigOptions.http.routers = routers;
    services.traefik.dynamicConfigOptions.http.services = services;
  };
}
