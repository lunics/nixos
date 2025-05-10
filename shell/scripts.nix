{ pkgs, ... }:{
  home.packages = with pkgs; [
    (import ./scripts/gen_pass.nix  { inherit pkgs; })
    (import ./scripts/passfzf.nix   { inherit pkgs; })
    (import ./scripts/pkg.nix       { inherit pkgs; })
    (import ./scripts/catt.nix      { inherit pkgs; })
    (import ./scripts/disk.nix      { inherit pkgs; })
  ];

  home.file = {
    # ".local/bin" = {     # KO permission denied
    #   source     = ./scripts;
    #   executable = true;
    #   recursive  = true; };

    # ".config/hypr/startup_apps".source = ./scripts/startup_apps;

    ".local/functions" = {
      source     = ./functions;
      recursive  = true; };
  };
}
