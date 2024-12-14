{ pkgs }: pkgs.writeShellApplication {
  name = "gen_pass";
  runtimeInputs = with pkgs; [ coreutils pwgen clipboard-jh ];
  text = ''
    arg1=$1
    arg2=$2
    length=$(shuf -i 20-25 -n 1)
    pass_generated=
    no_color='\033[0m'
    green='\033[0;32m'
    
    gen_pass (){
      while ! [ "$pass_generated" ]; do
        pass_generated=$(pwgen "$arg1" --num-passwords=1 "$arg2" | awk "/[0-9].*[0-9]/");
      done
    
      printf "%s" "$pass_generated" | cb
    
      printf "\nPassword: $green%s$no_color ($2 characters) copied in the clipboard !\n" "$pass_generated"
    }
    
    [ $# -eq 0 ] && gen_pass -cnsy "$length"
    
    if [ "$arg1" = "simple" ]; then
      if [[ $arg2 -ge 1 ]]; then
        gen_pass -cns "$arg1"
      else
        gen_pass -cns "$length"
      fi
    elif [[ $arg1 -ge 1 ]]; then
      gen_pass -cnsy "$arg1"
    fi
  '';
}
