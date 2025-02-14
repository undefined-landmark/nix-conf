{
  domain,
  subdomain,
  port,
}: {
  http = {
    routers = {
      "${subdomain}" = {
        service = subdomain;
        rule = "Host(`${subdomain}.${domain}`)";
      };
    };
    services = {
      "${subdomain}".loadBalancer.servers = [{url = "http://localhost:${port}";}];
    };
  };
}
