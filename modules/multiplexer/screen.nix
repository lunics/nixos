{
  programs.screen = {
    enable   = true;
    screenrc = ''
      termcapinfo xterm* ti@:te@
      defscrollback 1000000
      shell -$SHELL
      autodetach on
      startup_message off
      hardstatus off
      hardstatus alwayslastline
      hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %d-%m-%y %{W} %c %{g}]'
      wrap on
    '';
  };
}
