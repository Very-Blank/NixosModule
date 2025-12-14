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
        userEmail = "aapeli.saarelainen.76@gmail.com";
        userName = "very-blank";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };
    };
  };
}
