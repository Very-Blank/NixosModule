{
  lib,
  config,
  ...
}: {
  imports = [
    ./assembly
    ./c
    ./haskell
    ./lua
    ./python
    ./rust
    ./zig
  ];

  options = {
    modules = {
      developer = {
        languages = {
          enableAll = lib.mkEnableOption "Enables all of the language modules.";
        };
      };
    };
  };

  # FIXME: THIS is garbage do something like in the desktop module.
  config = let
    cfg = config.modules.developer.languages;
  in
    lib.mkIf cfg.enableAll {
      # NOTE: Don't try to be smart.
      modules = {
        developer = {
          languages = {
            assembly.enable = true;
            c.enable = true;
            haskell.enable = true;
            lua.enable = true;
            python.enable = true;
            rust.enable = true;
            zig.enable = true;
          };

          nvim.languages = ["nix" "assembly" "c" "haskell" "lua" "python" "rust" "zig"];
        };
      };
    };
}
