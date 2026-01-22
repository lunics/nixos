{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    systemd.network = {
      enable = true;
      netdevs = {
        "10-microvm".netdevConfig = {
          Kind = "bridge";
          Name = "bridge-microvm";
        };
      };
      networks = {
        "10-microvm" = {
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

        "11-microvm" = {
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
