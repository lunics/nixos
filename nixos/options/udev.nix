{ config, lib, ... }: with lib; {
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
  };
}
