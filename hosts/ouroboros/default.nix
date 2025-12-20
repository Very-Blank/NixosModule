{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "ouroboros";

    modules = {
      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer.enable = true;

      hardware = {
        backlight.enable = true;
        audio.enable = true;

        info = {
          battery = true;
        };
      };

      server = {
        openssh = {
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGU4pH0jqPg+3y2k0OqKhFZyw5MvQ7Z3y9A85QK2cNPu hermes"
          ];
        };

        openssh.enable = true;
      };

      graphical = {
        environment = {
          enable = true;
          windowManager = "niri";

          waybar = {
            enable = true;
            systemInfo.enable = true;
            tray.enable = true;
          };
        };
      };
    };
  };
}
