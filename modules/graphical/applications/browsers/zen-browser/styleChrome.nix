{palette}:
with palette; ''
  :root {
    --zen-colors-primary: #${base02} !important;
    --zen-primary-color: #${base0D} !important;
    --zen-colors-secondary: #${base02} !important;
    --zen-colors-tertiary: #${base01} !important;
    --zen-colors-border: #${base0D} !important;
    --toolbarbutton-icon-fill: #${base0D} !important;
    --lwt-text-color: #${base06} !important;
    --toolbar-field-color: #${base06} !important;
    --tab-selected-textcolor: #${base06} !important;
    --toolbar-field-focus-color: #${base06} !important;
    --toolbar-color: #${base05} !important;
    --newtab-text-primary-color: #${base06} !important;
    --arrowpanel-color: #${base05} !important;
    --arrowpanel-background: #${base00} !important;
    --sidebar-text-color: #${base06} !important;
    --lwt-sidebar-text-color: #${base06} !important;
    --lwt-sidebar-background-color: #${base00} !important;
    --toolbar-bgcolor: #${base02} !important;
    --newtab-background-color: #${base00} !important;
    --zen-themed-toolbar-bg: #${base00} !important;
    --zen-main-browser-background: #${base00} !important;
    --toolbox-bgcolor-inactive: #${base01} !important;
  }

  #permissions-granted-icon {
    color: #${base05} !important;
  }

  .sidebar-placesTree {
    background-color: #${base00} !important;
  }

  #zen-workspaces-button {
    background-color: #${base00} !important;
  }

  #TabsToolbar {
    background-color: #${base00} !important;
  }

  .urlbar-background {
    background-color: #${base02} !important;
  }

  .content-shortcuts {
    background-color: #${base00} !important;
    border-color: #${base0D} !important;
  }

  .urlbarView-url {
    color: #${base0D} !important;
  }

  #urlbar-input::selection {
    background-color: #${base0D} !important;
    color: #${base00} !important;
  }

  #zenEditBookmarkPanelFaviconContainer {
    background: #${base00} !important;
  }

  #zen-media-controls-toolbar {
    & #zen-media-progress-bar {
      &::-moz-range-track {
        background: #${base02} !important;
      }
    }
  }

  toolbar .toolbarbutton-1 {
    &:not([disabled]) {
      &:is([open], [checked])
        > :is(
          .toolbarbutton-icon,
          .toolbarbutton-text,
          .toolbarbutton-badge-stack
        ) {
        fill: #${base00};
      }
    }
  }

  .identity-color-blue {
    --identity-tab-color: #${base0D} !important;
    --identity-icon-color: #${base0D} !important;
  }

  .identity-color-turquoise {
    --identity-tab-color: #${base0C} !important;
    --identity-icon-color: #${base0C} !important;
  }

  .identity-color-green {
    --identity-tab-color: #${base0B} !important;
    --identity-icon-color: #${base0B} !important;
  }

  .identity-color-yellow {
    --identity-tab-color: #${base0A} !important;
    --identity-icon-color: #${base0A} !important;
  }

  .identity-color-orange {
    --identity-tab-color: #${base09} !important;
    --identity-icon-color: #${base09} !important;
  }

  .identity-color-red {
    --identity-tab-color: #${base08} !important;
    --identity-icon-color: #${base08} !important;
  }

  .identity-color-pink {
    --identity-tab-color: #${base0E} !important;
    --identity-icon-color: #${base0E} !important;
  }

  .identity-color-purple {
    --identity-tab-color: #${base0F} !important;
    --identity-icon-color: #${base0F} !important;
  }

  hbox#titlebar {
    background-color: #${base00} !important;
  }

  #zen-appcontent-navbar-container {
    background-color: #${base00} !important;
  }

  #contentAreaContextMenu menu,
  menuitem,
  menupopup {
    color: #${base05} !important;
  }
''
