{
  programs.zsh.initContent = ''
    for file in $HOME/.local/functions/*; do
      source $file
    done

    for file in $HOME/.local/functions/zsh/*; do
      source $file
    done
   
    ${builtins.readFile ./bindkeys.zsh }
  '';
}
