{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.useNetworkd = true;     # alias of systemd.network.enable = true;

    systemd.network = {
      enable = true;
      netdevs = {
        "bridge-microvm".netdevConfig = {
          Kind = "bridge";
          Name = "bridge-microvm";
        };
      };
      networks = {
        "bridge-microvm" = {
          matchConfig.Name = "bridge-microvm";
          networkConfig = {
            DHCPServer = true;
            IPv6SendRA = true;
          };
          addresses = [ 
            { Address = "10.0.0.1/24"; } 
            { Address = "fd12:3456:789a::1/64"; } 
          ];
          ipv6Prefixes = [ 
            { Prefix = "fd12:3456:789a::/64"; } 
          ];
        };

        "microvm-eth0" = {      ## eth0 or wlan0 to be more compliant to the reality ?
          matchConfig.Name = "vm-*";
          # Attach to the bridge that was configured above
          networkConfig.Bridge = "bridge-microvm";
        };
      };
      links = {};
      config = {
        addRouteTablesToIPRoute2 = true;
        networkConfig = {
          IPv6PrivacyExtensions = true;
        };
        routeTables  = {};
        dhcpV6Config = {};
        dhcpV4Config = {};
      };
    };
  };
}
