
{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      opencode = mkEnableOption "";
    };
  };
}
