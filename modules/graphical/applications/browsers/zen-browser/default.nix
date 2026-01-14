{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  options = {
    modules = {
      graphical = {
        applications = {
          browsers = {
            zen-browser = {
              enable = lib.mkEnableOption "Enables the zen-browser module.";
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.applications.browsers.zen-browser;
  in
    lib.mkIf cfg.enable {
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
            containersForce = true;
            containers = {};

            spacesForce = true;
            spaces = {
              "Space" = {
                id = "c6de089c-410d-4206-961d-ab11f988d40a";
                position = 1000;

                #   theme = {
                #     type = "gradient";
                #     colors = [
                #       {
                #         red = 30;
                #         green = 30;
                #         blue = 30;
                #       }
                #     ];
                #
                #     opacity = 1.0;
                #   };
              };
            };

            settings = {
              "browser.tabs.warnOnClose" = false;
              "browser.download.panel.shown" = false;
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

              "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

              "accessibility.typeaheadfind" = true;
              "accessibility.typeaheadfind.manual" = false;

              browser = {
                tabs.warnOnClose = false;
                download.panel.shown = false;
              };
            };

            extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
              ublock-origin
              leechblock-ng
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
                  definedAliases = ["@mn"]; # Keep in mind that aliases defined here only work if they start with "@"
                };
              };
            };

            userChrome = import ./styleChrome.nix {theme = config.scheme;};
            userContent = import ./styleContent.nix {theme = config.scheme;};
          };
        };
      };
    };
}
