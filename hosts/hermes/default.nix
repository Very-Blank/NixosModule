{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "hermes";

    modules = {
      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer = {
        enable = true; # FIXME: this is bad
        ssh.keys = [
          {
            match = "github.com";
            hostname = "github.com";
            user = "very-blank";
          }
          {
            match = "taildevourer.com";
            hostname = "taildevourer.com";
            user = "blank";
          }
          {
            match = "gitlab.jyu.fi";
            hostname = "gitlab.jyu.fi";
            user = "aapotska";
          }
          {
            match = "puhti.csc.fi";
            hostname = "puhti.csc.fi";
            user = "aapotska";
          }
        ];
      };

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        tuxedo.enable = true;
        backlight.enable = true;

        info = {
          battery = true;
        };
      };

      desktop = {
        enable = true;
        windowManager = "niri";

        bar = {
          enable = true;
          modules = ["tray" "systemInfo"];
        };

        applications = [
          "steam"
          "obsidian"
          "obs"
        ];
      };
    };
  };
}
