{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      editor = mkOption {
        type    = types.str;
        default = "nvim";
      };
    };
  };
}
