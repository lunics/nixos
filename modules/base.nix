{
  flake.modules.nixos.base = {
    # system architecture - required for nixos-builder to evaluate
    nixpkgs.hostPlatform.system = "x86_64-linux";

    system.stateVersion = "25.05";

    # disko manages fileSystems, ESP is at /boot
    boot.loader.systemd-boot.enable      = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.lunics = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
