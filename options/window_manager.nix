{ lib, ... }:{
  options._ = {
    window_manager = lib.mkEnableOption "";
    wayland_user  = lib.mkOption {
      type    = lib.types.str;
      default = "";
    };
  };
}
