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
          # gateway/DNS stay optional so a DHCP or RA-configured LAN needs no value
          networkConfig = {
            Address      = [ "${config._.net.addr.ipv4}/24" ]
                           ++ lib.optional config._.net.ipv6 "${config._.net.addr.ipv6}/64";
            IPv6AcceptRA = config._.net.ipv6;
          } // lib.optionalAttrs (config._.net.gateway != "") {
            Gateway      = config._.net.gateway;
          } // lib.optionalAttrs (config._.net.nameservers != []) {
            DNS          = config._.net.nameservers;
          };
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };
  };
}
