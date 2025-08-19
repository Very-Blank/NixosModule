{lib, config, ...}: {
  options = {
    modules = {
      developer = {
        git = {
          enable = lib.mkEnableOption "Git";
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.git.enable {
    homeUser = {
      programs.git = {
        enable = true;
        userEmail = "aapeli.saarelainen.76@gmail.com";
        userName = "very-blank";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };
    };
  };
}
