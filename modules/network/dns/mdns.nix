{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.mdns.backend = mkOption {
        type    = types.enum [ "avahi" "systemd-resolved" ];
        default = "avahi";
      };
    };

    # kept out of the dns aspect, <hostname>.local answered only where wanted
    mdns.nixos = { config, lib, ... }:
    let
      backend = config._.mdns.backend;
    in {
      services.avahi = lib.mkIf (backend == "avahi") {
        enable       = true;
        nssmdns4     = true;
        openFirewall = true;    # udp 5353
        publish      = {
          enable    = true;
          addresses = true;
        };
      };

      # only one of them may own udp 5353
      services.resolved.settings.Resolve.MulticastDNS = if backend == "systemd-resolved" then "yes" else "no";

      networking.firewall.allowedUDPPorts = [ 5353 ];

      # mdns support *.local by default so we shorten ssh <machine>.local to ssh <machine> when using ssh + certificate
      programs.ssh.extraConfig = ''
        CanonicalizeHostname yes
        CanonicalDomains     local
      '';
    };
  };
}
