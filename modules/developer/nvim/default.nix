{
  pkgs,
  inputs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "nvim" ] {
  config = {
    environment.systemPackages = [ inputs.nixnvim.packages.${pkgs.stdenv.system}.neovim ];

    # userHome = {
    #   programs.neovim = {
    #     enable = true;
    #     defaultEditor = true;
    #   };
    #
    #   xdg.configFile."nvim" = {
    #     enable = true;
    #     source = inputs.nvim;
    #   };
    # };
  };
}
