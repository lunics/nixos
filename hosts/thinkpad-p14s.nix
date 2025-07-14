{ config, options, ... }:{

  options.my = {
    pomodoro = lib.mkOption {
      type    = lib.types.bool;
      default = false;
    };
  };
}
