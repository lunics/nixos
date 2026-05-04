{
  flake.modules.generic.myoptions = { lib, ... }: with lib; {
    options._.sudo = {
      no_passwd = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
    };
  };
}
