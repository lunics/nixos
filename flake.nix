# sudo nixos-rebuild switch --flake /home/lunics/usb_copy/homelab/nixos/user#lunics
# sudo nixos-rebuild switch --flake ./#lunics
{
  inputs = {
    stable.url   = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {    # don't need in "outputs" to be installed for home-manager
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable"; };
    flake-home-manager.url = "git+file:/home/lunics/usb_copy/homelab/nixos/user";

    hyprland.url     = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "unstable"; };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "unstable"; };

    impermanence.url = "github:nix-community/impermanence";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "unstable"; };

    # crowdsec = {
    #   url = "git+https://codeberg.org/kampka/nix-flake-crowdsec.git";
    #   inputs.nixpkgs.follows = "unstable"; };

    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "unstable"; };
   
    # microvm = {
    #   url = "github:astro/microvm.nix";
    #   inputs.nixpkgs.follows = "unstable"; };

    # lix = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "unstable"; };
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "unstable"; };
    # attic = {
    #   url = "github:zhaofengli/attic";
    #   inputs.nixpkgs.follows = "unstable"; };
  };

  # outputs = { self, unstable, disko, agenix, impermanence, deploy-rs, nixvirt, microvm, ... }@inputs: {
  outputs = { self, unstable, disko, agenix, impermanence, deploy-rs, nixvirt, ... }@inputs: {
    nixosConfigurations.lunics = unstable.lib.nixosSystem {
      system      = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen3
          # src: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          # lenovo-thinkpad-t480
          # lenovo-thinkpad-t14
        agenix.nixosModules.default
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        # crowdsec.nixosModules.crowdsec
        nixvirt.nixosModules.default
        # microvm.nixosModules.microvm
        ./hardware.nix
        ./disko.nix
        ./boot.nix
        ./configuration.nix
        ./kernel.nix
        ./swap.nix
        ./services.nix
        ./location.nix
        ./network
        ./ntp.nix
        ./users.nix
        ./audio.nix
        ./login_manager.nix
        ./security
        ./fonts.nix
        ./window_manager.nix
        ./virtualisation
        ./gaming
      ];
    };
  };
}
