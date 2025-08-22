{ pkgs, ... }:let
  scripts = [
    ./gen_pass.nix
    ./passfzf.nix
    ./pkg.nix
    ./catt.nix      
    ./disk.nix
    #./ ssh.nix         # KO breaks git actions via SSH
    ./rr.nix
    ./timer.nix
    ./otp.nix
    ./toggle_bt_device.nix
  ];
in {
  home.packages = with pkgs; 
    map (item: import item { inherit pkgs; }) scripts;
}
