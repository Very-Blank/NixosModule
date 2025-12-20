{
  lib,
  config,
  mkIfModule,
  ...
}:
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
    ./ssh
  ]
  ++ map (x: (./. + "/languages/${x}")) languages;
}
// mkIfModule config [ "developer" ] {
  config = {
    modules.developer = {
      languages = lib.genAttrs languages (name: {
        enable = true;
      });

      git.enable = true;
      nvim.enable = true;
    };
  };
}
