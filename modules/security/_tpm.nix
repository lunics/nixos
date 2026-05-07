{
  flake.aspects.security.nixos = {
    security.tpm2 = {
      enable                 = true;
      pkcs11.enable          = true;
      tctiEnvironment.enable = true;
    };
  };
}
