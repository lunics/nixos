{ lib, ... }: with lib; {
  options._.hyprland = {
    toggle_bt = mkOption {
      type    = types.str;
      default = "$SUPER, B";
    };

    toggle_bar = mkOption {
      type    = types.str;
      default = "$SSHIFT, B";
    };

    prev_workspace = mkOption {
      type    = types.str;
      default = "49";       # keycode for ²
    };

    workspace = {
      "1" =  mkOption {
        type    = types.str;
        default = "ampersand";
      };
      "2" =  mkOption {
        type    = types.str;
        default = "eacute";
      };
      "3" =  mkOption {
        type    = types.str;
        default = "quotedbl";
      };
      "4" =  mkOption {
        type    = types.str;
        default = "apostrophe";
      };
      "5" =  mkOption {
        type    = types.str;
        default = "parenleft";
      };
      "6" =  mkOption {
        type    = types.str;
        default = "minus";
      };
      "7" =  mkOption {
        type    = types.str;
        default = "egrave";
      };
      "8" =  mkOption {
        type    = types.str;
        default = "underscore";
      };
      "9" =  mkOption {
        type    = types.str;
        default = "ccedilla";
      };
    };
  };
}
