{
  flake.aspects._plugins.homeManager = {
    imports = [ 
      ./hyprshell.nix
      # ./hyprwinwrap.nix
      # ./hyprexpo.nix
    ];
  };
}
