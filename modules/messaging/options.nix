{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      discord  = mkEnableOption "";
      matrix   = mkEnableOption "";
      whatsapp = mkEnableOption "";
    };
  };
}
