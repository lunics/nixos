{ config, lib, ... }: with lib; {
  options._.impermanence = {
    enable = mkEnableOption "";
    users  = mkOption {
      type = types.attrsOf (types.submodule ({ config, name, ... }: {
        options = {
          directories = mkOption {
            type    = 
            default =
          };
          files = mkOption {

          };
        };
      }));
    };
  };
}
