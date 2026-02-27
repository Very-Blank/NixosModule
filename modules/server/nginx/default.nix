{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      server = {
        nginx = {
          enable = lib.mkEnableOption "Enables the nginx module.";
          acme = {
            email = lib.mkOption {
              description = "Email address.";
              type = lib.types.nonEmptyStr;
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.server.nginx;
  in
    lib.mkIf cfg.enable {
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

          root = ./sefirah;

          extraConfig = ''
            add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;
            add_header 'Referrer-Policy' 'origin-when-cross-origin';
            add_header X-Frame-Options DENY;
            add_header X-Content-Type-Options nosniff;
            proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
          '';

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
