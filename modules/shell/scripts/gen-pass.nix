self: super: {
  gen-pass = super.writeShellApplication {
    name = "gen-pass";

    runtimeInputs = with super; [ 
      pwgen 
      coreutils     # to get: shuf
      wl-clipboard 
    ];

    text = ''
      length=$(shuf -i 25-30 -n 1)
      pass_generated=
      no_color="\033[0m"
      green="\033[0;32m"

      gen_pass (){
        _lenght=$2
      
        while ! [ "$pass_generated" ]; do           # needed to avoid sometimes a null value
          pass_generated=$(pwgen "$1" --num-passwords=1 "$_lenght" | awk "/[0-9].*[0-9]/");
        done
      
        _decimal=$((_lenght / 10))             # return the decimal of the lenght
        _spaces=$((RANDOM % (_decimal + 1)))        # pick a random number of spaces between 0 and (decimal + 1)
      
        pass_generated=$(echo "$pass_generated" | head -c -$((_spaces + 1)))    # remove the n last characters of the pass where n is the number of _spaces
      
        for _ in $(seq $_spaces); do                # loop from 1 to $count
          _space_position=$((RANDOM % "$_lenght"))  # define where a new space will be placed
          pass_generated=$(echo "$pass_generated" | sed -r "s/^.{$_space_position}/& /g")   # insert a new space at the position
        done
      
        printf "%s" "$pass_generated" | wl-copy     # better than echo to avoid the carriage return in the clipboard
      
        printf "\nPassword: $green%s$no_color ($2 characters) copied in the clipboard !\n" "$pass_generated"
      }
      
      if [ "$#" -gt 0 ]; then
        if [ "$1" = "simple" ]; then
          if [ -n "${"\$"}{2:-}" ]; then
            gen_pass -cns "$2"
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
  };
}
