{
  # lib,
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
    config =
      let
        sshPort = 22;
      in
      {
        services = {
          openssh = {
            enable = true;
            ports = [ sshPort ];

            settings = {
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
              PermitRootLogin = "no";
              AllowUsers = [ config.modules.home.user.name ];
            };
          };

          fail2ban.enable = true;
        };

        networking.firewall.allowedTCPPorts = [ sshPort ];
      };
  }
