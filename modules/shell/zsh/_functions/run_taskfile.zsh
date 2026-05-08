_run_taskfile() { 
  go-task --silent --dir $HOMELAB/scripts/taskfile $(go-task --dir $HOMELAB/scripts/taskfile -a | tr -d ' *:' | sed 1d | fzf)
  zle reset-prompt    # needed to avoid error if command cancel
}
