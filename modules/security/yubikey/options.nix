{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      yubikey = mkEnableOption "";

      udev.yubikey = {
        id_model_id = mkOption {
          type    = types.str;
          default = "0407";
        };
        id_vendor_id = mkOption {
          type    = types.str;
          default = "1050";
        };
        id_vendor = mkOption {
          type    = types.str;
          default = "Yubico";
        };
      };
    };
  };

  flake.aspects.yubikey.nixos = {
    _.yubikey = true;
  };
}
