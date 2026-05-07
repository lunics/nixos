{
  flake.aspects.security.nixos = {
    programs.gnupg.agent = {
      enable           = true;
      enableSSHSupport = true;
    };
  };
}
