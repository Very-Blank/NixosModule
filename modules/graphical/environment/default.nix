{
  lib,
  pkgs,
  config,
  mkIfModule,
  match,
  ...
}:
{

  imports = [
    ./fuzzel
    ./icons
    ./mako
    ./niri
    ./stylix
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

    browser = lib.mkOption {
      default = "firefox";
      description = "The enabled browser.";
      type = lib.types.nonEmptyStr;
    };

    applications = lib.mkOption {
      type = with lib.types; listOf nonEmptyStr;
      default = [ ];
      description = "Extra apps to be enabled.";
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
          fuzzel.enable = lib.mkForce true;
          stylix.enable = lib.mkForce true;

          niri = lib.mkIf (cfg.windowManager == "niri") {
            enable = lib.mkForce true;
            terminalEmulator = {
              enable = lib.mkForce true;
              path = lib.mkForce "${pkgs.ghostty}/bin/ghostty";
            };

            dmenu = {
              enable = lib.mkForce true;
              path = lib.mkForce "${pkgs.fuzzel}/bin/fuzzel";
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
