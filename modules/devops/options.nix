{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      ansible   = mkEnableOption "";

      terraform = mkEnableOption "";

      kube      = mkEnableOption "";

      mise      = mkEnableOption "";
    };
  };
}
