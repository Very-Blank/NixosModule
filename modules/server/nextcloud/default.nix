{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    modules = {
      server = {
        nextcloud = {
          enable = lib.mkEnableOption "Enables the nextcloud module.";
        };
      };
    };
  };

  config = let
    cfg = config.modules.server.nextcloud;
    subdomainName = "cloud";
  in
    lib.mkIf cfg.enable {
      sops.secrets."nextcloud/adminpass".sopsFile = ../../../secrets/other/. + "/${config.hostname}.yaml";

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud33;

        hostName = "${subdomainName}.${config.modules.server.domain.main}";
        https = true;
        configureRedis = true;

        maxUploadSize = "1G";

        config = {
          adminuser = config.hostname;
          adminpassFile = config.sops.secrets."nextcloud/adminpass".path;
          dbtype = "pgsql";
        };
      };

      # services.fail2ban = {
      #   enable = true;
      #   # The jail file defines how to handle the failed authentication attempts found by the Nextcloud filter
      #   # Ref: https://docs.nextcloud.com/server/latest/admin_manual/installation/harden_server.html#setup-a-filter-and-a-jail-for-nextcloud
      #   jails = {
      #     nextcloud.settings = {
      #       # START modification to work with syslog instead of logile
      #       backend = "systemd";
      #       journalmatch = "SYSLOG_IDENTIFIER=Nextcloud";
      #       # END modification to work with syslog instead of logile
      #       enabled = true;
      #       port = 443;
      #       protocol = "tcp";
      #       filter = "nextcloud";
      #       maxretry = 3;
      #       bantime = 86400;
      #       findtime = 43200;
      #     };
      #   };
      # };

      # environment.etc = {
      #   # Adapted failregex for syslogs
      #   "fail2ban/filter.d/nextcloud.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      #     [Definition]
      #     failregex = ^.*"remoteAddr":"&lt;HOST&gt;".*"message":"Login failed:
      #                 ^.*"remoteAddr":"&lt;HOST&gt;".*"message":"Two-factor challenge failed:
      #                 ^.*"remoteAddr":"&lt;HOST&gt;".*"message":"Trusted domain error.
      #   '');
      # };

      services.nginx.virtualHosts.${"${subdomainName}.${config.modules.server.domain.main}"} = {
        enableACME = true;
        forceSSL = true;
      };
    };
}
