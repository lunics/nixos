{
  systemd.network = {
    enable = true;
    networks = {
      "10-microvm" = {
        matchConfig.Name = "microvm";
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

      "11-microvm" = {
        matchConfig.Name = "vm-*";
        # Attach to the bridge that was configured above
        networkConfig.Bridge = "microvm";
      };
    };
    netdevs = {
      "10-microvm".netdevConfig = {
        Kind = "bridge";
        Name = "microvm";
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
}
