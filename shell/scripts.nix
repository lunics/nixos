{ pkgs, ... }:{
  home.packages = with pkgs; [
    (import ./scripts/gen_pass.nix  { inherit pkgs; })
    (import ./scripts/passfzf.nix   { inherit pkgs; })
    (import ./scripts/pkg.nix       { inherit pkgs; })
    (import ./scripts/catt.nix      { inherit pkgs; })
    (import ./scripts/disk.nix      { inherit pkgs; })
    # (import ./scripts/ssh.nix     { inherit pkgs; })    # KO breaks git actions via SSH
    (import ./scripts/rr.nix        { inherit pkgs; })
    (import ./scripts/timer.nix     { inherit pkgs; })
    (import ./scripts/otp.nix       { inherit pkgs; })
  ];

  home.file = {
    ".local/functions" = {
      source     = ./functions;
      recursive  = true; };
  };
}
