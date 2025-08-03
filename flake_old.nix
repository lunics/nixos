{
  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "unstable"; 
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "unstable"; 
    };

    # nur.url = "github:nix-community/NUR";   # Nixos community repo (for firefox-addons)

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "unstable"; 
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "unstable"; 
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "unstable";
    };

    flake-neovim.url = "git+file:/home/lunics/usb_copy/homelab/nixos/home/modules/neovim";
  };

  outputs = { self, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    homeConfigurations.lunics = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.unstable {
        inherit system;
        config.allowUnfree = true;
      };

      extraSpecialArgs = { inherit inputs; };

      modules = [
        ./modules
      ];
    };
  };
}
