{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    # wasistlos
    # whatsie             # required permittedInsecurePackages qtwebengine, more than 20 CVE from chromium
    # altus
  ];
}
