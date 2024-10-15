# sudo nixos-rebuild switch --flake /home/lunics/homelab#lunics
# sudo nixos-rebuild switch --flake ./#lunics
{
  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # hyprland.url     = "github:hyprwm/Hyprland";
    hyprland.url       = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs"; };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";
    # lix = {
    #  url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #  inputs.nixpkgs.follows = "nixpkgs"; };
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs"; };
    # deploy-rs = {
    #   url = "github:serokell/deploy-rs";
    #   inputs.nixpkgs.follows = "nixpkgs"; };
    # attic = {
    #   url = "github:zhaofengli/attic";
    #   inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, disko, agenix, impermanence, ... }@inputs: {
    nixosConfigurations.lunics = nixpkgs.lib.nixosSystem {    ## replace lunics by hostname target
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
        agenix.nixosModules.default
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        ./hardware-configuration.nix
        ./disko.nix
        ./boot.nix
        ./configuration.nix
        ./swap.nix
        ./services.nix
        ./location.nix
        ./network
        ./ntp.nix
        ./users.nix
        ./audio.nix
        ./fonts.nix
        ./login_manager.nix
        ./window_manager.nix
        ./virtualisation.nix
      ];
    };
  };
}
