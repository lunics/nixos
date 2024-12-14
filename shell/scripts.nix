{ pkgs, ... }:{
  home.packages = with pkgs; [
    (import ./scripts/gen_pass.nix { inherit pkgs; })
  ];

  home.file = {
    # ".local/bin" = {     # KO permission denied
    #   source     = ./scripts;
    #   executable = true;
    #   recursive  = true; };

    ".local/functions" = {
      source     = ./functions;
      recursive  = true; };
  };
}
