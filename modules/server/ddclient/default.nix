{
  # lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config
  [
    "server"
    "ddclient"
  ]
  {
    config = {
      sops.secrets."dns/token" = {
        sopsFile = ../../../secrets/other/. + "/${config.hostname}.yaml";
      };

      services.cloudflare-dyndns = {
        enable = true;
        apiTokenFile = config.sops.secrets."dns/token".path;

        domains = [
          config.modules.server.domain.name
        ];
      };
    };
  }

# { config, ... }:
# {
#   config = {
#   };
# }
