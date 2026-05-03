{ config, ... }:{
  programs.firefox.profiles.${config._.user}.extensions = {
    exactPermissions      = true;
    exhaustivePermissions = false;  # user must authorize requested permissions for all extensions
    force                 = true;   # override all previous extensions settings, required for declarative perms
  };

  imports = [
    ./packages.nix
    # ./settings.nix    not KO but doesn't apply anything
  ];
}
