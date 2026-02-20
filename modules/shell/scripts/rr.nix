{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "rr";

      text = ''
        # absolute_path=$(dirname $(realpath "$1"))
        no_color="\033[0m"
        green="\033[0;32m"

        printf "\nDelete $green%s$no_color [Enter] ?" "$*"; read -r

        if rm -frv "$*"; then
          echo -e "\nFile.s successfully removed"
        fi
      '';
    })
  ];
}
