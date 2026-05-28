{
  flake.aspects.microvm.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      ## reopen the advanced network configuration from the guide before implement this file
      systemd.network = {
        netdevs = {
          "bridge-microvm".netdevConfig = {
            Kind = "bridge";
            Name = "br0-microvm";
          };
        };
        networks = {
          "bridge-microvm" = {
            matchConfig.Name = "br0-microvm";
            networkConfig = {
              DHCPServer = true;
              # IPv6SendRA = true;
              # ConfigureWithoutCarrier = true;
            };
            addresses = [ 
              { Address = "10.0.0.1/24"; } 
              # { Address = "fd12:3456:789a::1/64"; } 
            ];
            # ipv6Prefixes = [ 
            #   { Prefix = "fd12:3456:789a::/64"; } 
            # ];
          };

          "tap-microvm" = {
            networkConfig.Bridge = "br0-microvm";
            matchConfig.Name     = "microvm-*";
          };
        };
        links = {};
        config = {
          addRouteTablesToIPRoute2 = true;
          networkConfig = {
            IPv6PrivacyExtensions = config._.microvm.ipv6;
          };
          routeTables  = {};
          dhcpV6Config = {};
          dhcpV4Config = {};
        };
      };
    };
  };
}
