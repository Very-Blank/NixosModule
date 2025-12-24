{
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "git" ] {
  config = {
    userHome = {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";

          user = {
            name = "very-blank";
            email = "aapeli.saarelainen.76@gmail.com";
          };
        };        
      };
    };
  };
}
