{lib, ...}: {
  options = {
    modules = {
      server = {
        domain = {
          main = lib.mkOption {
            default = "example.com";
            description = "Domain.";
            type = lib.types.nonEmptyStr;
          };
        };
      };
    };
  };
}
