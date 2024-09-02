# nixos-rebuild switch --flake /etc/nixos#lunics
# sudo nixos-rebuild switch --flake /home/lunics/nixos#lunics
# nixos-rebuild switch --flake github:owner/repo#your-hostname
{
  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url       = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.lunics = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14

        ./hardware-configuration.nix
        ./configuration.nix
        ./services.nix
        ./location.nix
        ./users.nix
        ./ntp.nix
        ./audio.nix
      ];
    };
  };
}
