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

  outputs = { self, unstable, nixos-hardware, disko, agenix, impermanence, deploy-rs, nixvirt, ... }@inputs: {
    nixosConfigurations = {
      hp-elitedesk-800g2 = unstable.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          ./hosts/hp-elitedesk-800g2
        ];
      };

      thinkpad-p14s = unstable.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen3
            # src: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
            # lenovo-thinkpad-t480
            # lenovo-thinkpad-t14
          # agenix.nixosModules.default
          disko.nixosModules.disko
          # impermanence.nixosModules.impermanence
          # crowdsec.nixosModules.crowdsec  ## don't forget to add in outputs
          nixvirt.nixosModules.default
          # microvm.nixosModules.microvm    ## don't forget to add in outputs
          ./hosts/thinkpad-p14s
        ];
      };
    };

    deploy.nodes = {
      hp-elitedesk-800g2 = {
        hostname = "hp-elitedesk-800g2";
        profiles.system = {
          sshUser         = "lunics";
          user            = "root";
          interactiveSudo = true;
          autoRollback    = true;         # previous profile re-activated if activation fails
          magicRollback   = true;
          remoteBuild     = false;         # build and fetch all external dependencies the derivation on the target system
          # tempPath        = "/home/lunics/.local/share/deploy-rs";       # currently only used by magicRollback, the path must be writable by deploy.nodes.NAME.profiles.system.user
          path            = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.hp-elitedesk-800g2;
        };
      };

      thinkpad-p14s = {
        hostname = "thinkpad-p14s";
        profiles.system = {
          # sshUser         = "lunics";
          user            = "root";
          interactiveSudo = true;
          autoRollback    = true;         # previous profile re-activated if activation fails
          magicRollback   = true;
          remoteBuild     = false;        # build and fetch all external dependencies the derivation on the target system
          tempPath        = "/home/lunics/.local/share/deploy-rs";       # currently only used by magicRollback, the path must be writable by deploy.nodes.NAME.profiles.system.user
          path            = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.thinkpad-p14s;
        };
      };
    };

    # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
