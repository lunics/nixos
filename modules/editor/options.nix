{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      editor = mkOption {
        type    = types.str;
        default = "nvim";
      };

      libreoffice = mkEnableOption "";
    };
  };
}
