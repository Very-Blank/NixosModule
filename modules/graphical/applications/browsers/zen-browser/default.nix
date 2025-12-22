{
  inputs,
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "applications" "browsers" "zen-browser" ] {
  config = {
    fonts = {
      packages = [
        pkgs.noto-fonts
        pkgs.noto-fonts-color-emoji
      ];
    };

    userHome = {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser = {
        enable = true;

        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };

        profiles."default" = {
          settings = {
            "browser.tabs.warnOnClose" = false;
            "browser.download.panel.shown" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            browser = {
              tabs.warnOnClose = false;
              download.panel.shown = false;
            };
          };

          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            bitwarden
          ];

          search = {
            force = true;
            default = "ddg";
            engines = {
              mynixos = {
                name = "My NixOS";
                urls = [
                  {
                    template = "https://mynixos.com/search?q={searchTerms}";
                    params = [
                      {
                        name = "query";
                        value = "searchTerms";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ]; # Keep in mind that aliases defined here only work if they start with "@"
              };
            };
          };

          userChrome = import ./styleChrome.nix { theme = config.scheme; };
          userContent = import ./styleContent.nix { theme = config.scheme; };
        };
      };
    };
  };
}
