{
  lib,
  pkgs,
  inputs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config ["developer" "nvim"] {
  config = {
    environment.systemPackages = [
      (inputs.nixnvim.packages.${pkgs.stdenv.system}.default.override {
        config.nixnvim.theming.theme.base16 = {
          enable = true;

          colors = {
            base00 = config.scheme.base00;
            base01 = config.scheme.base01;
            base02 = config.scheme.base02;
            base03 = config.scheme.base03;
            base04 = config.scheme.base04;
            base05 = config.scheme.base05;
            base06 = config.scheme.base06;
            base07 = config.scheme.base07;
            base08 = config.scheme.base08;
            base09 = config.scheme.base09;
            base0A = config.scheme.base0A;
            base0B = config.scheme.base0B;
            base0C = config.scheme.base0C;
            base0D = config.scheme.base0D;
            base0E = config.scheme.base0E;
            base0F = config.scheme.base0F;
          };
        };
      })
    ];

    userHome = {
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        GIT_EDITOR = "nvim";
      };

      programs.git = {
        settings = {
          core.editor = "nvim";
        };
      };
    };
  };
}
