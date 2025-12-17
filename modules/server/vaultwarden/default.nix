{
  # lib,
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

    config = cfg: {
      services.vaultwarden = {
        enable = true;
        backupDir = "/var/local/vaultwarden/backup";
        # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
        # be aware that this file must be created by hand (or via secrets management like sops)
        environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
        config = {
          # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
          DOMAIN = "https://vault.${config.modules.server.tailscale.domain}";
          SIGNUPS_ALLOWED = false;

          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          ROCKET_LOG = "critical";
        };
      };

      services.nginx.virtualHosts."${config.modules.server.tailscale.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${config.services.vaultwarden.config.ROCKET_PORT}";
        };
      };
    };
  }
