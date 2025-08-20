{lib, config, ...}:
{
  options = {
    modules = {
      graphical = {
        mako = {
          enable = lib.mkEnableOption "Mako";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.mako.enable {
    userHome = {
      services.mako = {
        enable = true;

        settings = {
          default-timeout = 1500;
          border-radius = 10;
          border-size = 0;
        };
      };
    };
  };
}
