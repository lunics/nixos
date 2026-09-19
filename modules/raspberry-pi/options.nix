{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.raspberry-pi = mkEnableOption "";
  };
}
