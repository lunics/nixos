{
  flake.aspects.programs.nixos = {
    programs = {
      zsh.enable  = true;
      bash.enable = true;
    };
  };
}
