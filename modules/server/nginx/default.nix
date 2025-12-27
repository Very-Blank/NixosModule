{
  lib,
  pkgs,
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

      # appendHttpConfig = ''
      #   # Enable CSP for your services.
      #   #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;
      #
      #   # Minimize information leaked to other domains
      #   add_header 'Referrer-Policy' 'origin-when-cross-origin';
      #
      #   # Disable embedding as a frame
      #   add_header X-Frame-Options DENY;
      #
      #   # Prevent injection of code in other mime types (XSS Attacks)
      #   add_header X-Content-Type-Options nosniff;
      #
      #   # This might create errors
      #   proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
      # '';

      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      virtualHosts.${config.modules.server.domain.main} = {
        forceSSL = true;
        enableACME = true;
        reuseport = true;

        root = ./sefirah;

        locations."/" = {
          index = "index.html";
        };
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
