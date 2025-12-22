{
  theme,
  fontFamily,
  fontWeight,
}:
''
  * {
      border: none;
      border-radius: 0;
      font-family: '${fontFamily}';
      font-weight: ${fontWeight};
      min-height: 20px;
  }

  window#waybar {
      background: transparent;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  #workspaces {
      margin-right: 8px;
      border-radius: 10px;
      transition: none;
      background: #${theme.base00};
  }

  #workspaces button {
      transition: none;
      color: #${theme.base03};
      background: transparent;
      padding: 5px;
      font-size: 18px;
  }

  #workspaces button.persistent {
      color: #${theme.base04};
      font-size: 12px;
  }

  #workspaces button:hover {
      transition: none;
      box-shadow: inherit;
      text-shadow: inherit;
      border-radius: inherit;
      color: #${theme.base00};
      background: #${theme.base03};
  }

  #workspaces button.active {
      background: #${theme.base01};
      color: #${theme.base06};
      border-radius: inherit;
  }

  #keyboard-state {
      margin-right: 8px;
      padding-left: 16px;
      padding-right: 16px;
      border-radius: 10px;
      transition: none;
      color: #${theme.base06};
      background: #${theme.base00};
  }

  #custom-poweroff, #custom-hibernate, #custom-reboot {
      padding-left: 14px;
      margin-right: 8px;
      padding-right: 18px;
      border-radius: 10px;
      transition: none;
      color: #${theme.base06};
      background: #${theme.base00};
  }

  #clock, #pulseaudio, #cpu, #memory, #backlight, #battery, #tray {
      margin-right: 8px;
      padding-left: 16px;
      padding-right: 16px;
      border-radius: 10px;
      transition: none;
      color: #${theme.base06};
      background: #${theme.base00};
  }

  #pulseaudio.muted {
      background-color: #${theme.base0E};
      color: #${theme.base00};
  }

  #battery.charging {
      background-color: #${theme.base0B};
      color: #${theme.base00};
  }

  #battery.warning:not(.charging) {
      background-color: #${theme.base0A};
      color: #${theme.base00};
  }

  #battery.critical:not(.charging) {
      background-color: #${theme.base08};
      color: #${theme.base00};
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
  }

  @keyframes blink {
      to {
          background-color: #${theme.base06};
          color: #${theme.base00};
      }
  }
''
