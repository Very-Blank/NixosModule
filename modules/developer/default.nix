{ config, lib, ... }:
let
  languages = [
    "zig"
    "lua"
    "python"
    "asm"
    "haskell"
    "nix"
    "c"
    "rust"
  ];
in
{
  imports = [
    ./git
    ./nvim
  ]
  ++ map (x: (./. + "/languages/${x}")) languages;

  options = {
    modules = {
      developer = {
        enable = lib.mkEnableOption "Enables basic developer tools and languages";
      };
    };
  };

  config = lib.mkIf config.modules.developer.enable {
    modules.developer = {
      languages = lib.genAttrs languages (name: {
        enable = true;
      });

      git.enable = true;
      nvim.enable = true;
    };
  };
}
