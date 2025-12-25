{
  config,
  mkIfModule,
  ...
}:
mkIfModule config
[
  "server"
  "vaultwarden"
]
{
  options = {};

  config = cfg: let
    subdomainName = "vault";
  in {
    sops.secrets."vaultwarden/env".sopsFile = ../../../secrets/other/. + "/${config.hostname}.yaml";

    modules.server.domain.subs = [subdomainName];

    services.vaultwarden = {
      enable = true;
      environmentFile = config.sops.secrets."vaultwarden/env".path;

      config = {
        DOMAIN = "https://${subdomainName}.${config.modules.server.domain.main}";
        SIGNUPS_ALLOWED = false;

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
      };
    };

    services.nginx.virtualHosts.${"${subdomainName}.${config.modules.server.domain.main}"} = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      };
    };
  };
}
