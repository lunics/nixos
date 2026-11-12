{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      discord  = mkEnableOption "";
      matrix   = mkEnableOption "";
      whatsapp = mkEnableOption "";
    };
  };
}
