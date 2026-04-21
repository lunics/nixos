{
  imports = [
    ./main.nix
    ./file_sharing.nix
    ./sys_info.nix
    ./rclone.nix
    # ./neofetch.nix    # unmaintained upstream, use fastfetch instead
    # ./yubikey.nix
    ./anki.nix
    ./tigervnc.nix
    ./winboat.nix 
    ./devbox.nix
    ./direnv.nix
    ./mullvad.nix
  ];
}
