{
  flake.aspects.messaging.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      karere        # new wasistlos replacement
      # wasistlos   # removed because unmaintained and archived upstream
      # whatsie     # required permittedInsecurePackages qtwebengine, more than 20 CVE from chromium
      # altus
    ];
  };
}
