{
  flake.modules.generic.options = { lib, ... }: with lib; {
    options._ = {
      hostName = mkOption {
        type    = types.str;
        default = "nixos";
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
