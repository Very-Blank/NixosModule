{
  lib,
  config,
  mkModule,
  ...
}: let
  languages = [
    "zig"
    "lua"
    "python"
    "assembly"
    "haskell"
    "nix"
    "c"
    "rust"
  ];
in
  {
    imports =
      [
        ./git
        ./nvim
        ./ssh
      ]
      ++ map (x: (./. + "/languages/${x}")) languages;
  }
  // mkModule config ["developer"] {
    options = {
      languages = lib.mkOption {
        default = [];
        description = "Languages to be enabled.";
        type = lib.type.listOf (lib.type.enum languages);
      };
    };

    config = cfg: {
      modules.developer = {
        languages = cfg.languages;

        git.enable = true;
        nvim.enable = true;

        nvim.defaultEditor = true;
        nvim.languages = cfg.languages;
      };
    };
  }
