{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      mouse-usb-id = {
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
  };
}
