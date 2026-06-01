{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      hostName = mkOption {
        type    = types.str;
        default = "nixos";
      };

      net = {
        ipv6 = mkEnableOption "";   # toggle globally ipv6

        ext-interface = mkOption {
          type    = types.str;
          default = "";
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

      mullvad = mkEnableOption "";
    };
  };
}
