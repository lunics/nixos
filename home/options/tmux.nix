{ lib, ... }: with lib; {
  options._.tmux = {
    prev_tab = mkOption {
      type    = types.str;
      default = "h";
    };

    next_tab = mkOption {
      type    = types.str;
      default = "l";
    };

    swap_pane_hori = mkOption {
      type    = types.str;
      default = "j";
    };
  };
}
