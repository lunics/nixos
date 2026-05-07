{
  flake.aspects.programs.nixos = {
    programs.fuse = {
      userAllowOther = true;
      mountMax       = 1000; # default=1000
    };
  };
}
