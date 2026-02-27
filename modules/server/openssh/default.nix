{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      server = {
        openssh = {
          enable = lib.mkEnableOption "Enables the openssh module.";

          port = lib.mkOption {
            type = lib.types.ints.unsigned;
            default = 22;
            description = "Port that the ssh service uses.";
          };

          keys = lib.mkOption {
            type = lib.types.listOf lib.types.singleLineStr;
            description = "All of the authorized keys for ssh.";
            default = [];
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.server.openssh;
  in
    lib.mkIf cfg.enable {
      services = {
        openssh = {
          enable = true;
          ports = [cfg.port];
          openFirewall = false;

          banner = ''

             ██████╗ ██╗   ██╗██████╗  ██████╗ ██████╗  ██████╗ ██████╗  ██████╗ ███████╗
            ██╔═══██╗██║   ██║██╔══██╗██╔═══██╗██╔══██╗██╔═══██╗██╔══██╗██╔═══██╗██╔════╝
            ██║   ██║██║   ██║██████╔╝██║   ██║██████╔╝██║   ██║██████╔╝██║   ██║███████╗
            ██║   ██║██║   ██║██╔══██╗██║   ██║██╔══██╗██║   ██║██╔══██╗██║   ██║╚════██║
            ╚██████╔╝╚██████╔╝██║  ██║╚██████╔╝██████╔╝╚██████╔╝██║  ██║╚██████╔╝███████║
             ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                                       A private ssh service.
                                       Authorized users only,
                                             thank you.

          '';

          settings = {
            PermitRootLogin = "no";

            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;

            AllowUsers = [config.modules.home.user.name];
          };
        };

        fail2ban = {
          enable = true;
          maxretry = 2;

          bantime = "2h";
          bantime-increment = {
            enable = true;
            multipliers = "1 2 4 8 16 32 64";
            rndtime = "1h";
          };

          jails = {
            sshd = {
              settings = {
                enable = true;
                backend = "systemd";
                mode = "aggressive";
                bantime = "2h";
                maxretry = 3;
              };
            };
          };
        };
      };

      users.users.${config.modules.home.user.name}.openssh.authorizedKeys.keys = cfg.keys;

      networking.firewall.allowedTCPPorts = [cfg.port];
    };
}
