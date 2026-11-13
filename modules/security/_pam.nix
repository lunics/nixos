{
  flake.aspects.pam.nixos = {
    security.pam.services = {
      login = {
        # u2fAuth    = true;
        enableGnomeKeyring = true;    ## can be toggle if add option keyring = false
      };
      # u2fAuth is redundant, security.pam.u2f.enable already applies to every service
      # sudo.u2fAuth     = true;
      # swaylock.u2fAuth = true;
      # hyprlock.u2fAuth = true;
    };
  };
}
