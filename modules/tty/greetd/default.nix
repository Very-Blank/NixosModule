{config, pkgs, ...} : {
  config = {
    services.greetd = {
      enable = true;
      settings = {
        terminal = {
          vt = 1;
        };
        
        # TODO: MAKE THIS BUETIFULLLLL and not autoenable
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.niri}/bin/niri-session";
          user = "greeter";
        };
      };
    };
  };
}
