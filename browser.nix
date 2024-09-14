{ pkgs, ... }:{
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.firefox.enable = true;
}
