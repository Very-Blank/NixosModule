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

          subs = lib.mkOption {
            type = with lib.types; listOf nonEmptyStr;
            default = [];
            description = "Sumbdomains of the main domain.";
          };
        };
      };
    };
  };
}
