{ pkgs }: pkgs.writeShellApplication {
  name = "gen_pass";
  runtimeInputs = with pkgs; [ 
    coreutils 
    pwgen 
    wl-clipboard 
  ];

  text = ''
    length=$(shuf -i 20-25 -n 1)
    pass_generated=
    no_color='\033[0m'
    green='\033[0;32m'
    
    gen_pass (){
      while ! [ "$pass_generated" ]; do
        pass_generated=$(pwgen "$1" --num-passwords=1 "$2" | awk "/[0-9].*[0-9]/");
      done
    
      printf "%s" "$pass_generated" | wl-copy
    
      printf "\nPassword: $green%s$no_color ($2 characters) copied in the clipboard !\n" "$pass_generated"
    }
    
    if [ "$#" -gt 0 ]; then
      if [ "$1" = "simple" ]; then
        if [[ $2 -ge 1 ]]; then
          gen_pass -cns "$1"
        else
          gen_pass -cns "$length"
        fi
      elif [[ $1 -ge 1 ]]; then
        gen_pass -cnsy "$1"
      fi
    elif [ "$#" -eq 0 ]; then
      gen_pass -cnsy "$length"
    fi
  '';
}
