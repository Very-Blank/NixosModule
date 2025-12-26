{
  lib,
  pkgs,
  config,
  mkIfModule,
  ...
}:
{
  imports = [
    ./launchers
    ./icons
    ./mako
    ./niri
    ./swaybg
    ./waybar
  ];
}
// mkIfModule config [ "graphical" "environment" ] {
  options = {
    windowManager = lib.mkOption {
      default = "niri";
      description = "The enabled window manager.";
      type = lib.types.enum [
        "niri"
        # "sway"
        # "hyprland"
      ];
    };

    terminal = lib.mkOption {
      default = "ghostty";
      description = "The enabled terminal emulator.";
      type = lib.types.enum [
        "ghostty"
      ];
    };

    launcher = lib.mkOption {
      default = "vicinae";
      description = "The enabled launcher.";
      type = lib.types.enum [
        "fuzzel"
        "vicinae"
      ];
    };

    browser = lib.mkOption {
      default = "zen-browser";
      description = "The enabled browser.";
      type = lib.types.enum [
        "firefox"
        "zen-browser"
      ];
    };

    applications = lib.mkOption {
      default = [ ];
      description = "Extra apps to be enabled.";
      type =
        with lib.types;
        listOf (enum [
          "obsidian"
          "obs"
          "steam"
        ]);
    };
  };

  config = cfg: {
    environment = {
      systemPackages = [
        pkgs.uwsm
      ];
    };

    modules = {
      tty.greetd = lib.mkIf (cfg.windowManager == "niri") {
        enable = true;
        cmd = lib.mkForce "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.niri}/bin/niri --session >/dev/null 2>&1";
      };

      graphical = {
        environment = {
          mako.enable = lib.mkForce true;
          swaybg.enable = lib.mkForce true;

          launchers."${cfg.launcher}".enable = true;

          niri = lib.mkIf (cfg.windowManager == "niri") {
            enable = true;

            spawn-at-startup = [
              {
                command = [
                  "vicinae"
                  "server"
                ];
              }
            ];

            keybinds = with config.userHome.lib.niri.actions; {
              "Mod+D" = lib.mkMerge [
                (lib.mkIf (cfg.launcher == "vicinae") {
                  repeat = false;
                  action = spawn [
                    "vicinae"
                    "toggle"
                  ];
                })
                (lib.mkIf (cfg.launcher == "fuzzel") {
                  action = spawn "${pkgs.fuzzel}/bin/fuzzel";
                })
              ];

              "Mod+T".action = spawn "${pkgs.ghostty}/bin/ghostty";
            };
          };
        };

        applications.browsers.${cfg.browser}.enable = true;

        applications.other = lib.genAttrs cfg.applications (name: {
          enable = true;
        });
      };

      terminal.ghostty.enable = lib.mkForce true;
    };
  };
}
