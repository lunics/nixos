# sudo nixos-rebuild switch --flake /home/lunics/homelab#lunics
# sudo nixos-rebuild switch --flake ./#lunics
{
  inputs = {
    stable.url   = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {    ## verify if needed to added in "outputs"
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable"; };

    hyprland.url     = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; };

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "unstable"; };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "unstable"; };

    impermanence.url = "github:nix-community/impermanence";

    # lix = {
    #  url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #  inputs.nixpkgs.follows = "unstable"; };
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "unstable"; };
    # deploy-rs = {
    #   url = "github:serokell/deploy-rs";
    #   inputs.nixpkgs.follows = "unstable"; };
    # attic = {
    #   url = "github:zhaofengli/attic";
    #   inputs.nixpkgs.follows = "unstable"; };
  };

  outputs = { self, unstable, disko, agenix, impermanence, ... }@inputs: {
    nixosConfigurations.***REMOVED*** = unstable.lib.nixosSystem {    ## replace lunics by hostname target
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
