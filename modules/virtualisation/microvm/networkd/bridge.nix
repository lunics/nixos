# simple network setup: bridge on real eth0 + TAP interfaces
# https://microvm-nix.github.io/microvm.nix/simple-network.html
{
  flake.aspects.networkd-bridge.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      # networkd owns br0 and its uplink here, keep NetworkManager away from both
      networking.networkmanager.unmanaged = [
        "interface-name:br0"
        "interface-name:${config._.net.ext-interface}"
      ];

      systemd.network = {
        # br0 carries the host address here, so waiting for it is meaningful
        wait-online = {
          enable       = true;
          anyInterface = false;
        };

        networks."10-lan" = {
          matchConfig.Name = ["${config._.net.ext-interface}" "mvm-*"];
          networkConfig = {
            Bridge = "br0";
          };
        };
        
        netdevs."br0" = {
          netdevConfig = {
            Name = "br0";
            Kind = "bridge";
          };
        };
        
        networks."10-lan-bridge" = {
          matchConfig.Name = "br0";
          networkConfig = {
            Address      = ["${config._.net.addr.ipv4}/24" "2001:db8::a/64"];
            Gateway      = "192.168.1.1";
            DNS          = ["192.168.1.1"];
            IPv6AcceptRA = true;
          };
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };
  };
}
