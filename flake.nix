# sudo nixos-rebuild switch --flake /home/lunics/homelab#lunics
# sudo nixos-rebuild switch --flake ./#lunics
{
  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs/nixos-unstable";
    # unstable.url = ""
    # stable.url = ""
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # hyprland.url       = "github:hyprwm/Hyprland";
    hyprland.url       = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.lunics = nixpkgs.lib.nixosSystem {    ## replace lunics by hostname target
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
        ./hardware-configuration.nix
        ./boot.nix
        ./configuration.nix
        ./swap.nix
        ./services.nix
        ./location.nix
        ./network.nix
        ./ntp.nix
        ./users.nix
        ./audio.nix
        ./fonts.nix
        ./hyprland.nix
        ./vpn.nix
        ./virtualisation.nix
      ];
    };
  };
}
