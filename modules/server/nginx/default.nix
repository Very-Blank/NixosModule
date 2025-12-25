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

        virtualHosts.${config.modules.server.domain.main} = {
          forceSSL = true;
          enableACME = true;
          reuseport = true;
        };
      };

      users.users."nginx".extraGroups = [ "acme" ];
    };
  }
