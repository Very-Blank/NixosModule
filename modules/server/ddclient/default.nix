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
      sops.secrets."ddclient/password" = {
        sopsFile = ../../secrets/user/. + "/${config.hostname}.yaml";
      };

      services.ddclient = {
        enable = true;
        interval = "5min";
        protocol = "cloudflare";
        username = config.modules.domain.name;
        passwordFile = config.sops.secrets."ddclient/password".path;

        domains = [
          config.modules.domain.name
        ];
      };
    };
  }

# { config, ... }:
# {
#   config = {
#   };
# }
