{ config, lib, ... }: with lib; {
  options._.ssh_config = mkOption {
    type = types.attrsOf (types.submodule ({ config, name, ... }:{
      options = {
        user = mkOption {
          type    = types.nullOr types.str;
          default = null;
        };

        identityFile = mkOption {
          type    = types.oneOf [ (types.listOf types.str) types.str types.null ];
          default = [];
        };

        hostname = mkOption {
          type    = types.nullOr types.str;
          default = null;
        };
      };
    }));
  };
}
