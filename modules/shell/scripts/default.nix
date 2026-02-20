{
  imports = [ 
    ./catt.nix
    ./gen-pass.nix
    ./passfzf.nix
    ./pkg.nix
    ./disk.nix
    # ./ssh.nix         # KO breaks git actions via SSH
    ./rr.nix
    ./timer.nix
    ./otp.nix
    ./toggle_bt_device.nix
    ./toggle_vpn.nix
    ./_suspend.nix
    ./_poweroff.nix
  ];
}
