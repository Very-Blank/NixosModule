{lib, config, pkgs, ...}: {
  options = {
    modules = {
      graphical = {
        waybar = {
          enable = lib.mkEnableOption "Waybar";
          tray = {
            enable = lib.mkEnableOption "Tray";
          };
          systemInfo = {
            enable = lib.mkEnableOption "System info";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.waybar.enable {
    fonts = {
      packages = [
        pkgs.nerd-fonts._0xproto
      ];
    };

    modules.graphical.stylix.enable = lib.mkForce true;

    userHome = {
      gtk = lib.mkIf config.modules.graphical.waybar.tray.enable {
        enable = true;
        iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
      };

      programs.waybar = let processedDefines = pkgs.replaceVars ./style.css config.lib.stylix.colors; in {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            margin = "5 10 5 10";
            modules-center = ["clock"];

            modules-left = lib.mkMerge [
              (lib.mkIf config.modules.graphical.niri.enable ["niri/workspaces"])
              ["keyboard-state" "custom/poweroff" "custom/hibernate" "custom/reboot"]
            ];

            modules-right = lib.mkMerge [
              (lib.mkIf config.modules.hardware.audio.enable ["pipewire"])
              (lib.mkIf config.modules.hardware.backlight.enable ["backlight"])
              (lib.mkIf config.modules.graphical.waybar.systemInfo.enable ["memory" "cpu"])
              (lib.mkIf config.modules.hardware.battery.enable ["battery"])
              (lib.mkIf config.modules.graphical.waybar.tray.enable ["tray"])
            ];

            "keyboard-state" = {
              capslock = true;
              format = "{icon}";
              format-icons = {
                locked = "";
                unlocked = "";
              };
            };

            "clock" = {
              format = "{:%a %d %b %I:%M %p}";
              tooltip = false;
            };

            "custom/poweroff" = {
              format = "";
              on-double-click = "poweroff";
              tooltip = false;
            };

            "custom/hibernate" = {
              format = "⭘";
              on-double-click = "systemctl hibernate";
              tooltip = false;
            };

            "custom/reboot" = {
              format = "";
              on-double-click = "reboot";
              tooltip = false;
            };

            "pipewire" = lib.mkIf config.modules.hardware.audio.enable {
              reverse-scrolling = 1;
              format = "{volume}% {icon} {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = " {format_source}";
              format-source = "{volume}% ";
              format-source-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["" "" ""];
              };
              on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
              min-length = 13;
            };

            "memory" = lib.mkIf config.modules.graphical.waybar.systemInfo.enable {
              interval =  30;
              format = "{}% ";
            };

            "cpu" = lib.mkIf config.modules.graphical.waybar.systemInfo.enable {
              interval = 2;
              format = "{usage}% ";
              min-length = 6;
            };

            "backlight" = lib.mkIf config.modules.hardware.backlight.enable {
              device = "intel_backlight";
              format = "{percent}% {icon}";
              format-icons = ["󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
              min-length = 7;
            };

            "battery" = lib.mkIf config.modules.hardware.battery.enable {
              interval = 2;
              states = { warning = 30; critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% 󰂄";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };

            "tray" = lib.mkIf config.modules.graphical.waybar.tray.enable {
              icon-size = 20;
              spacing = 10;
            };
          };
        };

        style = processedDefines;
      };
    };
  };
}
