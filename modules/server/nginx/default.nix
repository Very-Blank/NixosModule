{
  lib,
  pkgs,
  config,
  inputs,
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

        serverTokens = false;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

        appendHttpConfig = ''
          limit_req_zone $binary_remote_addr zone=general:10m rate=10r/s;
        '';

        virtualHosts.${config.modules.server.domain.main} = {
          forceSSL = true;
          enableACME = true;
          reuseport = true;

          root = inputs.sefirah.packages.${pkgs.stdenv.system}.default;

          extraConfig = ''
            limit_req zone=general burst=10 nodelay;
            limit_req_status 429;
            add_header Strict-Transport-Security "max-age=31536000" always;
            add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self'; font-src 'self'; object-src 'none'; base-uri 'none'; frame-ancestors 'none';" always;
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
