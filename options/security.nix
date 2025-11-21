{ lib, ... }: with lib; {
  options._ = {
    yubikey = mkEnableOption "";

    u2f_keys = mkOption {
      type    = types.path;
      default = "";
    };
  };
}
