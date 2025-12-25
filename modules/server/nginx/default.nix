{
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config
[
  "server"
  "nginx"
]
{
  options = {
    acme = {
      email = lib.mkOption {
        description = "Email address";
        type = lib.types.nonEmptyStr;
      };
    };
  };

  config = cfg: {
    security.acme = {
      acceptTerms = true;
      defaults.email = cfg.acme.email;
    };

    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      virtualHosts.${config.modules.server.domain.main} = {
        forceSSL = true;
        enableACME = true;
        reuseport = true;
      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };

    users.users."nginx".extraGroups = ["acme"];
  };
}
