{
  nix.registry."NAME" = {   # system-wide flake registry
    exact = true;       # the from reference (like nixpkgs) needs to match exactly
    flake =             # flake input from is rewritten to
    from = {
      id = "nixpkgs";
      type = "indirect";
    };
    to = {
      owner = "my-org";
      repo = "my-nixpkgs";
      type = "github";
    };
  };
}
