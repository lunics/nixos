{ config, ... }:{ 
  home.shellAliases = {
    l     = "exa -l --group-directories-first --git-repos --hyperlink -X";
    p     = "pkg";
    g     = "lazygit";
    h     = "helm";
    q     = "exit";
    r     = "trash";
    s     = "sudo";
    t     = "go-task --dir $HOME/usb_copy/homelab/scripts/taskfile $(go-task --dir $HOME/usb_copy/homelab/scripts/taskfile --list-all | tr -d ' *:' | sed 1d | fzf)";
    v     = "nvim";
    w     = "which+";
    x     = "sxiv -ft *";
    y     = "yazi";
    c-    = "cd -";
    bc    = "numbat";
    cp    = "cp --recursive --reflink=auto";
    df    = "duf --hide special";
    du    = "dust";
    ez    = "exec zsh";
    ia    = "chatblade --chat-gpt 3.5 --stream";
    ip    = "ip --color=auto";
    la    = "eza -lag --group-directories-first";
    ln    = "ln -s";
    py    = "python";
    ss    = "sudo systemctl";
    fk    = "fuck";
    md    = "mkdir --parents --verbose";
    ra    = "ranger_no_subshell";
    tt    = "taskwarrior-tui";
    ".."  = "cd ..";
    "..." = "cd ../..";
    cat   = "catt";
    top   = "btm";
    vim   = "nvim";
    pwd   = "command pwd | tee /dev/tty | wl-copy";   ## TODO convertir en function pour gérer la sortie quand le chemin n'existe plus
    calc  = "numbat";
    # wget  = "echo Use http/https instead        #";
    # curl  = "echo Use http/https instead        #";
    pass  = "passfzf";
    copy  = "rsync -rlptgoDvzh --progress";
    # gpg = "/usr/bin/gpg --homedir {{ path_share }}/gnupg";
    size  = "dust";
    tree  = "eza -T";
    wifi  = "nmcli c";
    mkdir = "mkdir --parents --verbose";
    move  = "mv --verbose";
    grep  = "rg -i";
    grpe  = "rg -i";
    gpre  = "rg -i";
    pgrep = "pgrep -i";
    pgrpe = "pgrep -i";
    clip  = "wl-copy";
    clipboard = "clip";
    extract = "ouch decompress";
    reload  = "exec zsh";
    paste   = "wl-paste";
    vimdiff = "nvim -d";
    taskfile = "go-task";
    calendar = "cal";
    # suspend:    sudo systemctl suspend  # save state fast to the RAM but lost sessions if battery down
    # hibernate                           # save state slowly to the disk and don't lost session if battery down but slower to power on
    # hybrid-sleep Hibernate and suspend  # save state to RAM then to disk so the power on is faster if battery is still on
    # Suspend & hibernate                 # Suspend the system, wake after a period of time and put it into hibernate
    logout   = "systemctl restart getty@tty1.service";
    poweroff = "save_env && sudo /run/current-system/sw/bin/poweroff";
    suspend  = "save_env && systemctl suspend";
    reboot   = "save_env && systemctl reboot";
    battery  = "sudo tlp chargeonce";       ## delete if charge_once used
    charge_once  = "sudo tlp chargeonce";
    stop_pomodoro  = "systemctl --user stop  pomodoro.timer && systemctl --user stop  pomodoro.service && echo '0' > /tmp/pomodoro_cycle";
    start_pomodoro = "echo '0' > /tmp/pomodoro_cycle && systemctl --user start pomodoro.timer";

    synth-helm = "${config._.home}/.nix-profile/bin/helm";
    l_mount = "df -aTh --total";
    l_date  = "eza -la --sort=mod";
    l_filesystems = "lsblk --fs; df -Th --total";
    l_vm    =  "sudo virsh list --all";
    log_kernel  =  "journalctl -xb";
    log_kernel2 = "sudo dmesg -TxH --follow";
    log_hypr    = "{{ 'cat {{ path_logs }}/hyprland.log' if compositor == 'wayland' }}";
    su-systemd  = "machinectl shell [username]@.host";             ## a tester: new su for systemd
    
    mpv     = "mpv --input-ipc-server=/tmp/mpvsoc$(date +%s)";
    sstatus = "sudo systemctl status";
    sstart  = "ss start";
    srestart = "ss restart";
    sstop   = "ss stop";
    chmod   = "chmod -v";
    chown   = "chown -v";
    "700"   = "chmod 700";
    "600"   = "chmod 600";
    jtodo   = "$JOPLIN edit 0e29a; $JOPLIN sync";
    jls     = "$JOPLIN use ToDo && $JOPLIN ls -l && echo; $JOPLIN use Notes && $JOPLIN ls -l";
    diff    = "diff --color=auto";
    ccat    = "highlight --out-format=ansi";
    yt      = "youtube-dl --add-metadata -i";
    yta     = "yt -x -f bestaudio/best";
    YT      = "youtube-viewer";
    ref     = "shortcuts >/dev/null; source ~/.config/shortcutrc";
    # tmux    = "unset TMUX; exec /usr/bin/env tmux -f $HOME/.config/tmux/tmux.conf";
    ffmpeg  = "ffmpeg -hide_banner";
    # wget    = "/usr/bin/wget --hsts-file=$CACHE/wget-hsts";   ## after implementing wget in roles/packages --config=$CONFIG/wget/wget.conf
  };
}
