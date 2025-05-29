{ pkgs }: pkgs.writeShellApplication {
  name = "otp";
  runtimeInputs = with pkgs; [ 
    wl-clipboard-rs
    oath-toolkit
  ];

  text = ''
    read -sp "Enter the otp secret key: " -r secret
    
    oathtool -b --totp=SHA1 "$secret" | wl-copy; echo
    
    echo "code: $(wl-paste)"
  '';
}

