{
  pkgs,
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "environment" "waybar" ] {
  options = {
    tray = {
      enable = lib.mkEnableOption "System tray.";
    };

    systemInfo = {
      enable = lib.mkEnableOption "System info.";
    };
  };

  config = cfg: {
    fonts = {
      packages = [
        pkgs.nerd-fonts._0xproto
      ];
    };

    modules.graphical.environment = {
      icons.enable = lib.mkIf cfg.tray.enable true;
    };

    programs = {
      waybar = {
        enable = true;
      };
    };

    userHome = {
      programs.waybar =
        let
          base00 = "1e2030";
          base01 = "363a4f";
          base02 = "494d64";
          base03 = "5b6078";
          base04 = "6e738d";
          base05 = "8a8fa1";
          base06 = "b5b9cc";
          base07 = "f0f0f6";
          base08 = "f4dbd6";
          base09 = "f0c6c6";
          base0A = "f5bde6";
          base0B = "eed49f";
          base0C = "a6da95";
          base0D = "8aadf4";
          base0E = "7dc4e4";
          base0F = "939ab7";
          processedDefines = pkgs.writeText "waybar-colors.css" (
            builtins.replaceStrings
              [
                "__base00__"
                "__base01__"
                "__base02__"
                "__base03__"
                "__base04__"
                "__base05__"
                "__base06__"
                "__base07__"
                "__base08__"
                "__base09__"
                "__base0A__"
                "__base0B__"
                "__base0C__"
                "__base0D__"
                "__base0E__"
                "__base0F__"
              ]
              [
                base00
                base01
                base02
                base03
                base04
                base05
                base06
                base07
                base08
                base09
                base0A
                base0B
                base0C
                base0D
                base0E
                base0F
              ]
              (builtins.readFile ./style.css)
          );
        in
        {
          enable = true;
          style = processedDefines;
          settings = {
            mainBar = {
              layer = "top";
              position = "top";
              margin = "5 10 5 10";
              modules-center = [ "clock" ];

              modules-left = lib.mkMerge [
                (lib.mkIf config.modules.graphical.environment.niri.enable [ "niri/workspaces" ])
                [
                  "keyboard-state"
                  "custom/poweroff"
                  "custom/hibernate"
                  "custom/reboot"
                ]
              ];

              modules-right = lib.mkMerge [
                (lib.mkIf config.modules.hardware.audio.enable [ "pulseaudio" ])
                (lib.mkIf config.modules.hardware.backlight.enable [ "backlight" ])
                (lib.mkIf cfg.systemInfo.enable [
                  "memory"
                  "cpu"
                ])
                (lib.mkIf config.modules.hardware.info.battery [ "battery" ])
                (lib.mkIf cfg.tray.enable [ "tray" ])
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

              "pulseaudio" = lib.mkIf config.modules.hardware.audio.enable {
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
                  default = [
                    ""
                    ""
                    ""
                  ];
                };
                on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
                min-length = 13;
              };

              "memory" = lib.mkIf cfg.systemInfo.enable {
                interval = 30;
                format = "{}% ";
              };

              "cpu" = lib.mkIf config.modules.graphical.environment.waybar.systemInfo.enable {
                interval = 2;
                format = "{usage}% ";
                min-length = 6;
              };

              "backlight" = lib.mkIf config.modules.hardware.backlight.enable {
                device = "intel_backlight";
                format = "{percent}% {icon}";
                format-icons = [
                  "󰛩"
                  "󱩎"
                  "󱩏"
                  "󱩐"
                  "󱩑"
                  "󱩒"
                  "󱩓"
                  "󱩔"
                  "󱩕"
                  "󱩖"
                  "󰛨"
                ];
                min-length = 7;
              };

              "battery" = lib.mkIf config.modules.hardware.info.battery {
                interval = 2;
                states = {
                  warning = 30;
                  critical = 15;
                };
                format = "{capacity}% {icon}";
                format-charging = "{capacity}% 󰂄";
                format-plugged = "{capacity}% ";
                format-alt = "{time} {icon}";
                format-icons = [
                  "󰁺"
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
              };

              "tray" = lib.mkIf cfg.tray.enable {
                icon-size = 20;
                spacing = 10;
              };
            };
          };
        };
    };
  };
}
