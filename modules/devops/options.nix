{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      ansible   = mkEnableOption "";

      terraform = mkEnableOption "";

      kube      = mkEnableOption "";

      mise      = mkEnableOption "";
    };
  };
}
