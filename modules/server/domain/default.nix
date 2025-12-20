{
  lib,
  config,
  mkModule,
  ...
}:
mkModule config
  [
    "server"
    "domain"
  ]
  {
    options = {
      name = lib.mkOption {
        default = "example.com";
        description = "Domain.";
        type = lib.types.nonEmptyStr;
      };
    };
  }
