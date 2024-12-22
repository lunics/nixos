{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";  # [ "firefox.desktop" ]; ?
      "text/xml"  = "firefox.desktop"; 
      "x-scheme-handler/http"    = "firefox.desktop";
      "x-scheme-handler/https"   = "firefox.desktop";
      "x-scheme-handler/about"   = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
