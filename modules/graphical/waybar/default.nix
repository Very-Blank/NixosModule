{lib, config, pkgs, ...}: {
  # systemd.user.services.nm-applet = {
  #   Unit = {
  #     Description = "Nm-applet service";
  #     PartOf = [ "graphical-session.target"  "dbus.socket" ];
  #     After = [ "graphical-session.target"  "dbus.socket" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  #     Restart     = "on-failure";
  #     RestartSec  = "5s";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };
  #
  # systemd.user.services.blueman-applet = {
  #   Unit = {
  #     Description = "Blueman-applet service";
  #     PartOf = [ "graphical-session.target"  "dbus.socket" ];
  #     After = [ "graphical-session.target"  "dbus.socket" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.blueman}/bin/blueman-applet";
  #     Restart     = "on-failure";
  #     RestartSec  = "5s";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  # programs.waybar = {
  #   settings = {
  #     mainBar = {
  #       modules-right = ["pulseaudio" "memory" "cpu" "backlight" "battery" "tray"];
  #       "tray" = {
  #         icon-size = 20;
  #         spacing = 10;
  #       };
  #     };
  #   };
  # };

  config = {
    userHome = {
      programs.waybar = let
        processedDefines = pkgs.replaceVars ./style.css config.lib.stylix.colors;
        in {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            margin = "5 10 5 10";
            modules-center = ["clock"];

            modules-left = ["niri/workspaces" "niri/language" "keyboard-state" "custom/poweroff" "custom/hibernate" "custom/reboot"];

            "niri/language" = {
              format-en = "US";
            };

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

            "pulseaudio" = {
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
              on-click = "pavucontrol";
              min-length = 13;
            };

            "memory" = {
              interval =  30;
              format = "{}% ";
            };

            "cpu" = {
              interval = 2;
              format = "{usage}% ";
              min-length = 6;
            };

            "temperature" = {
              # thermal-zone = 2;
              # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
              critical-threshold = 80;
              # format-critical = "{temperatureC}°C {icon}";
              format = "{temperatureC}°C {icon}";
              format-icons = ["" "" "" "" ""];
              tooltip = false;
            };

            "backlight" = {
              device = "intel_backlight";
              format = "{percent}% {icon}";
              format-icons = ["󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
              min-length = 7;
            };

            "battery" = {
              interval = 2;
              states = { warning = 30; critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% 󰂄";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
          };
        };

        style = processedDefines;
      };
    };
  };
}
