{config, pkgs, ...} : {
  config = {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = config.modules.home.user.name;
        };
      };
    };
  };
}
