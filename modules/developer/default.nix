{config, lib, ...}: {
  imports = [
    ./git
    ./nvim
    ./tooling
    ./zig
  ];

  options = {
    modules = {
      developer = {
        enable = lib.mkEnableOption "Enables basic developer tools";
      };
    };
  };

  config = lib.mkIf config.modules.developer.enable {
    modules.developer.nvim.enable = true;
    modules.developer.git.enable = true;
    modules.developer.tooling.enable = true;
  };
}

