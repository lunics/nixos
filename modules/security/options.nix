{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      yubikey = mkEnableOption "";

      u2f_keys = mkOption {
        type    = types.nullOr types.path;
        default = null;
      };

      pass_manager = mkOption {
        type    = types.str;
        default = "gopass";
      };

      passage = mkEnableOption "";

      age_identities = lib.mkOption {
        type    = types.nullOr types.path;
        default = null;
      };

      sops-group = mkOption {
        type    = types.str;
        default = "sops";
      };
    };
  };
}
