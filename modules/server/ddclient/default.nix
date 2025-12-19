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
    options = {
    };

    config = {
      # sops.secrets."ddclient/password" = {
      #   sopsFile = ../../secrets/other/shared/secrets.yaml;
      # };

      # services.ddclient = {
      #   enable = true;
      #   interval = "5min";
      #   protocol = "cloudflare";
      #   username = config.domain;
      #   passwordFile = config.sops.secrets."ddclient/password".path;
      #   domains = [
      #     "*.${config.domain}"
      #     "@.${config.domain}"
      #   ];
      # };
    };
  }

# { config, ... }:
# {
#   config = {
#   };
# }
