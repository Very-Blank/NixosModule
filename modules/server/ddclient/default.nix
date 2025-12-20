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

      services.ddclient = {
        enable = true;
        interval = "5min";
        protocol = "cloudflare";
        username = "aapeli.saarelainen.76@gmail.com";
        passwordFile = config.sops.secrets."dns/token".path;

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
