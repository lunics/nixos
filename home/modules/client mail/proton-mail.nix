{ pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    protonmail-desktop        # KO Missing proton-mail.desktop file
    protonmail-bridge         # to use the ProtonMail account with any email client
    # protonmail-bridge-gui   # Qt-based GUI to use your ProtonMail account with your local e-mail client
  ];
}
