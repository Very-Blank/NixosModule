{
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config
  [
    "server"
    "openssh"
  ]
  {
    options = {
      port = lib.mkOption {
        type = lib.types.ints.unsigned;
        default = 22;
        description = "Port that the ssh service uses.";
      };

      keys = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        description = "All of the authorized keys for ssh.";
        default = [ ];
      };
    };

    config = cfg: {
      services = {
        openssh = {
          enable = true;
          ports = [ cfg.port ];
          openFirewall = false;

          settings = {
            PermitRootLogin = "no";

            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;

            AllowUsers = [ config.modules.home.user.name ];
          };
        };

        fail2ban.enable = true;
      };

      users.users.${config.modules.home.user.name}.openssh.authorizedKeys.keys = cfg.keys;

      networking.firewall.allowedTCPPorts = [ cfg.port ];
    };
  }
