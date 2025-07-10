{ pkgs, ... }:{
  xdg = {
    mime = {
      enable                  = true;
      desktopFileUtilsPackage = pkgs.desktop-file-utils;  # desktop-file-utils package to use. Used when running update-desktop-database
      sharedMimeInfoPackage   = pkgs.shared-mime-info ;   # shared-mime-info package to use. Used when running update-mime-database
    };

    mimeApps = {
      enable = false;
      # defaultApplications = {
      #   "text/html" = "firefox.desktop";  # [ "firefox.desktop" ]; ?
      #   "text/xml"  = "firefox.desktop"; 
      #   "x-scheme-handler/http"    = "firefox.desktop";
      #   "x-scheme-handler/https"   = "firefox.desktop";
      #   "x-scheme-handler/about"   = "firefox.desktop";
      #   "x-scheme-handler/unknown" = "firefox.desktop";
      # };
      # associations = {
      #   added = {
      #     "mimetype1" = [ "foo1.desktop" "foo2.desktop" "foo3.desktop" ];
      #     "mimetype2" = "foo4.desktop";
      #   };
      #   removed = {
      #     mimetype1 = "foo5.desktop";
      #   };
      # };
    };
  };
}
