{
  # lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config
  [
    "server"
    "nginx"
  ]
  {
    config = {
      services = {
        nginx = {
          enable = true;
        };
      };

      security.acme = {
        acceptTerms = true;
        defaults.email = "aapeli.saarelainen.76@gmail.com";
      };
    };
  }
