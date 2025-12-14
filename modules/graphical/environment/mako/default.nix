{
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "environment" "mako" ] {
  config = {
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
