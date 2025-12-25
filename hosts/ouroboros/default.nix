{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "ouroboros";

    services.upower.ignoreLid = true;
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;

    modules = {
      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      tty = {
        greetd.autoLogin = true;
      };

      developer = {
        enable = true;
        ssh.keys = [
          {
            match = "github.com";
            hostname = "github.com";
            user = "very-blank";
          }
        ];
      };

      hardware = {
        backlight.enable = true;

        info = {
          battery = true;
        };
      };

      server = {
        openssh = {
          enable = true;
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGU4pH0jqPg+3y2k0OqKhFZyw5MvQ7Z3y9A85QK2cNPu hermes"
          ];
        };

        domain.main = "taildevourer.com";
        ddclient.enable = true;

        nginx = {
          enable = true;
          acme.email = "aapeli.saarelainen.76@gmail.com";
        };
      };
    };
  };
}
