{ pkgs, ... }:{
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
}
