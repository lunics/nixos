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

    # my-options.url = "git+file:/home/lunics/usb_copy/homelab/nixos/options";
  };

  outputs = { self, unstable, nixos-hardware, disko, agenix, impermanence, nixvirt, deploy-rs, ... }@inputs: {
    nixosModules.system = = import ./modules;

#     nixosConfigurations = {
#       hp-elitedesk-800g2 = unstable.lib.nixosSystem {
#         system      = "x86_64-linux";
#         specialArgs = { inherit inputs; };
#         modules = [
#           disko.nixosModules.disko
#           ./hosts/hp-elitedesk-800g2      # replace by elitedesk-800g2 
#         ];
#       };

#       thinkpad-p14s = unstable.lib.nixosSystem {
#         system      = "x86_64-linux";
#         specialArgs = { inherit inputs; };
#         modules = [
#           nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen3
#             # src: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
#             # lenovo-thinkpad-t480
#             # lenovo-thinkpad-t14
#           # agenix.nixosModules.default
#           disko.nixosModules.disko
#           # impermanence.nixosModules.impermanence
#           # crowdsec.nixosModules.crowdsec  ## don't forget to add in outputs
#           nixvirt.nixosModules.default
#           # microvm.nixosModules.microvm    ## add in outputs
#           ./hosts/thinkpad-p14s
#           my-options.nixosModules.my_variables
#         ];
#       };
#     };

#     deploy.nodes = {
#       hp-elitedesk-800g2 = {
#         hostname = "hp-elitedesk-800g2";
#         profiles.system = {
#           sshUser           = "lunics";
#           user              = "root";
#           path              = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.hp-elitedesk-800g2;
#         };
#       };

#       thinkpad-p14s = {
#         hostname = "thinkpad-p14s";
#         profiles.system = {
#           # sshUser         = "lunics";
#           user            = "root";
#           interactiveSudo = true;
#           path            = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.thinkpad-p14s;
#         };
#       };
#     };

#     # atm broken, because it evaluates everything instead of just the current target
#     checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
