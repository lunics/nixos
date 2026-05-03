{ config, lib, dns, ... }:{
  config = lib.mkIf config._.dns.nsd {
    services.nsd.zones = {
      "thinkpad-t14" = {
        # provideXFR = [ ... ];
        # notify = [ ... ];
        data = dns.lib.toString "thinkpad-t14" (import ./thinkpad-t14.nix { inherit dns; });
      };
    };
  };
}
