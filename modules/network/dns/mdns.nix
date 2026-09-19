{
  # kept out of the dns aspect, resolved answers <hostname>.local only where wanted
  flake.aspects.mdns.nixos = {
    services.resolved.settings.Resolve.MulticastDNS = "yes";

    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
