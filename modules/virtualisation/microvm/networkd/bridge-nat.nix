# advanced network setup: bridge on virtual veth0 + NAT + TAP interfaces
# https://microvm-nix.github.io/microvm.nix/advanced-network.html
{
  flake.aspects.networkd-bridge-nat.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      systemd.network = {
        netdevs."10-microvm".netdevConfig = {
          Kind = "bridge";
          Name = "microvm";
        };
        networks."10-microvm" = {
          matchConfig.Name = "microvm";
          networkConfig = {
            DHCPServer = true;
            IPv6SendRA = true;
          };
          addresses = [{
            addressConfig.Address = "10.0.0.1/24";
          }{
            addressConfig.Address = "fd12:3456:789a::1/64";
          }];
          ipv6Prefixes = [{
            ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
          }];
        };
        networks."11-microvm" = {
          matchConfig.Name = "mvm-*";
          # Attach to the bridge that was configured above
          networkConfig.Bridge = "microvm";
        };        
      };

      # allow inbound traffic for the DHCP server
      networking.firewall.allowedUDPPorts = [ 67 ];

      networking.nat = {
        enable = true;
        # NAT66 exists and works. But if you have a proper subnet in
        # 2000::/3 you should route that and remove this setting:
        enableIPv6 = true;
      
        # Change this to the interface with upstream Internet access
        externalInterface = "enp10s0";
        # The bridge where you want to provide Internet access
        internalInterfaces = ["microvm"];

        ## TODO to make your MicroVM’s services available to networks outside your host!
        # forwardPorts = [{
        #   proto       = "tcp";
        #   sourcePort  = 80;
        #   destination = my-addresses.http-reverse-proxy.ip4;
        # }{
        #   proto       = "tcp";
        #   sourcePort  = 443;
        #   destination = my-addresses.https-reverse-proxy.ip4;
        # }];
      };
    };
  };
}
