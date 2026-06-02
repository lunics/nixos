{
  flake.aspects.messaging.homeManager = { config, pkgs, lib, ... }:{ 
    config = lib.mkIf config._.whatsapp {
      home.packages = with pkgs; [
        karere        # new wasistlos replacement
        # wasistlos   # removed because unmaintained and archived upstream
        # whatsie     # required permittedInsecurePackages qtwebengine, more than 20 CVE from chromium
        # altus
      ];
    };
  };
}
