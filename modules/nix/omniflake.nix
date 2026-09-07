{
  flake-file.inputs.omniflake = {
    url = "github:fzakaria/omniflake";
    inputs = {
      nixpkgs.follows      = "nixpkgs";
      systems.follows      = "systems";
      flake-parts.follows  = "flake-parts";
      flake-compat.follows = "flake-compat";
    };
  };
}
