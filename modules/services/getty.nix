{
  flake.aspects.getty.nixos = { ... }:{
    # types.lines, so this appends to the nixos-help line and keeps the
    # default greeting "<<< Welcome to NixOS ... (\m) - \l >>>" untouched
    services.getty.helpLine = ''

      \e{cyan}host  \e{reset} \n (\s \m)
      \e{cyan}kernel\e{reset} \r
      \e{cyan}net   \e{reset} \4
      \e{cyan}date  \e{reset} \d \t
      \e{cyan}users \e{reset} \U
    '';
  };
}
