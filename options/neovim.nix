{ lib, ... }: with lib; {
  options._.neovim = {
    keymap = {
      left = mkOption {
        type    = types.str;
        default = "h";
      };

      right = mkOption {
        type    = types.str;
        default = "l";
      };

      up = mkOption {
        type    = types.str;
        default = "k";
      };

      down = mkOption {
        type    = types.str;
        default = "j";
      };

      insert = mkOption {
        type    = types.str;
        default = "i";
      };

      replace = mkOption {
        type    = types.str;
        default = "r";
      };

      undo = mkOption {
        type    = types.str;
        default = "u";
      };

      redo = mkOption {
        type    = types.str;
        default = "U";
      };
    };
  };
}
