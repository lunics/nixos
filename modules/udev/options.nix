{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.udev = {
      disable_mouse_wakeup = {
        id_vendor = mkOption {
          type    = types.str;
          default = "";
        };
        id_product = mkOption {
          type    = types.str;
          default = "";
        };
      };
      yubikey = {
        id_model_id = mkOption {
          type    = types.str;
          default = "0406";
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
}
