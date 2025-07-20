_run_taskfile() { 
  go-task -d $HOMELAB/taskfile $(go-task -d $HOMELAB/taskfile -a | tr -d ' *:' | sed 1d | fzf)
  zle reset-prompt    # needed to avoid error if command cancel
}
