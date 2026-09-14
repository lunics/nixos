{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      window_manager = mkOption {
        type    = types.str;
        default = "";
      };
      wayland_user   = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
