{ lib, ... }: with lib; {
  options._.tmux = {
    prev_tab = mkOption {
      type    = types.str;
      default = "M-h";
    };
    next_tab = mkOption {
      type    = types.str;
      default = "M-l";
    };
  };
}
