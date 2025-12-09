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
  ++ map (x: "./languages/" + x) languages;

  options = {
    modules = {
      developer = {
        enable = lib.mkEnableOption "Enables basic developer tools and languages";
      };
    };
  };

  config = lib.mkIf config.modules.developer.enable {
    # modules.developer = {
    #   languages = {
    #     zig.enable = true;
    #     lua.enable = true;
    #     python.enable = true;
    #     asm.enable = true;
    #     haskell.enable = true;
    #     nix.enable = true;
    #     c.enable = true;
    #     rust.enable = true;
    #   };
    # };

    modules.developer = {
      languages = lib.genAttrs (map (x: x + ".enable") languages) (name: true);
      git.enable = true;
      nvim.enable = true;
    };
  };
}
