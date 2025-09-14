{ lib, ... }: with lib; {
  options._.yazi = {
    left = mkOption {
      type    = types.str;
      default = "h";
    };

    right = mkOption {
      type    = types.str;
      default = "l";
    };

    down = mkOption {
      type    = types.str;
      default = "j";
    };

    up = mkOption {
      type    = types.str;
      default = "k";
    };

    scroll_up = mkOption {
      type    = types.str;
      default = "K";
    };

    scroll_down = mkOption {
      type    = types.str;
      default = "J";
    };

    rename = mkOption {
      type    = types.str;
      default = "r";
    };
  };
}
