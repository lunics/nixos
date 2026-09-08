{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      hostname = mkOption {
        type    = types.str;
        default = "nixos";
      };

      bluetooth-devices = mkOption {
        type = types.listOf (types.submodule {
          options = {
            name = mkOption {
              type    = types.str;
              default = "";
            };
            mac = mkOption {
              type    = types.str;
              default = "";
            };
          };
        });
        default = [];
      };

      net = {
        ipv6 = mkEnableOption "";   # toggle globally ipv6

        ext-interface = mkOption {
          type    = types.str;
          default = "";
        };

        gateway = mkOption {
          type    = types.str;
          default = "";
        };

        nameservers = mkOption {
          type    = types.listOf types.str;
          default = [];
        };

        addr = {                    # used in static allocation
          ipv4 = mkOption {
            type    = types.str;
            default = "";
          };
          ipv6 = mkOption {
            type    = types.str;
            default = "";
          };
        };
      };

      dns = {
        bind9 = mkEnableOption "";
        nsd   = mkEnableOption "";
        etc_hosts = mkOption {
          type    = types.str;
          default = "";
        };
      };
    };
  };
}
