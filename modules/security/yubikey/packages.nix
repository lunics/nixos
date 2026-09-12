{
  flake.aspects.yubikey.nixos = { pkgs, ... }:{
    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubikey-touch-detector
      yubikey-agent         # ssh-agent for yubikey
      yubico-pam
      pam_u2f
      age-plugin-yubikey
      pcsclite
      yubikey-personalization
      # yubikey-full-disk-encryption
    ];
  };
}
