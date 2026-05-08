{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      window_manager = mkEnableOption "";
      wayland_user   = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
