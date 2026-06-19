{
  flake.aspects.xdg = {
    # Portals allow interaction with system, like choosing files or taking screenshots
    nixos = { pkgs, ... }:{
      xdg.portal = {
        enable = false;           ## if not headless
        extraPortals = [          # additional portals to add to path
          # xdg-desktop-portal-gtk
          # xdg-desktop-portal-kde
        ];
        config           = {};
        configPackages   = [];
        xdgOpenUsePortal = false; # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1 This will make xdg-open use the portal to open programs, which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers
        wlr = {
          enable   = false;
          settings = {};
        };
        lxqt = {
          enable = false;
          styles = [];
        };
      };
    };

    homeManager = { pkgs, ... }:{
      xdg.portal = {
        enable = false;
        # config = {
        #   common = {
        #     default = [
        #       "gtk"
        #     ];
        #   };
        # };
        # configPackages   = [ pkgs.gnome.gnome-session ];
        # extraPortals     = [];
        # xdgOpenUsePortal = false;
      };
    };
  };
}
