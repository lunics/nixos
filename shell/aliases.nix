{ home.shellAliases = {

a     = "ansible-playbook";
l     = "exa -l --group-directories-first --git-repos --hyperlink";
g     = "lazygit";
q     = "exit";
r     = "trash";
s     = "sudo";
t     = "go-task";
v     = "nvim";
w     = "watch -n 2 -d";
x     = "sxiv -ft *";
la    = "eza -lag --group-directories-first";
ip    = "ip --color=auto";
ss    = "sudo systemctl";
fk    = "fuck";
md    = "mkdir --parents --verbose";
ra    = "ranger_no_subshell";
tf    = "terraform";
py    = "python";
c-    = "cd -";
".."  = "cd ..";
"..." = "cd ../..";
ia    = "chatblade --chat-gpt 3.5 --stream";
cp    = "cp --reflink=auto";
vim   = "nvim";
pass  = "passage";
pwd   = "command pwd | tee /dev/tty | wl-copy";   ## TODO convertir en function pour gérer la sortie quand le chemin n'existe plus
cat   = "bat";
copy  = "rsync -rlptgoDvzh --progress";
calc  = "/usr/bin/bc -q";
# gpg = "/usr/bin/gpg --homedir {{ path_share }}/gnupg";
size  = "du -sh";
tree  = "eza -T";
wifi  = "nmcli c";
mkdir = "mkdir --parents --verbose";
move  = "mv --verbose";
grpe  = "grep -i";
gpre  = "grep -i";
pgrep = "pgrep -i";
pgrpe = "pgrep -i";
clip  = "wl-copy";
clipboard = "clip";
reload  = "exec zsh";
paste   = "wl-paste";
vimdiff = "nvim -d";
# suspend:    sudo systemctl suspend  # save state fast to the RAM but lost sessions if battery down
# hibernate                           # save state slowly to the disk and don't lost session if battery down but slower to power on
# hybrid-sleep Hibernate and suspend  # save state to RAM then to disk so the power on is faster if battery is still on
# Suspend & hibernate                 # Suspend the system, wake after a period of time and put it into hibernate
logout   = "systemctl restart getty@tty1.service";
poweroff = "sudo poweroff";
suspend  = "systemctl suspend";

# kubernetes
# kubectl = "/usr/bin/kubectl --cache-dir ~/.cache/kube";
k       = "kubectl";
kk      = "c $LINUX/kubernetes";
kcc     = "k config current-context";
kg      = "k get";
ka      = "k get all --all-namespaces";
knodes  = "k get nodes -o wide";
kp      = "k get pods --all-namespaces -o wide";
ks      = "k get services";
kt      = "k top nodes --use-protocol-buffers; echo; k top pods --use-protocol-buffers";
kd      = "k get deployments --all-namespaces";
kv      = "k get pv,pvc";
kapply  = "k apply -f";
ki      = "k get ingresses.networking.k8s.io --all-namespaces";
helm    = "/run/current-system/sw/bin/helm";
synth-helm = "/home/lunics/.nix-profile/bin/helm";
h       = "helm";
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
upc     = "sudo pacman -Syu; pkill -RTMIN+8 i3blocks";
lsp     = "pacman -Qett --color=always | less";
# tmux    = "unset TMUX; exec /usr/bin/env tmux -f $HOME/.config/tmux/tmux.conf";
ffmpeg  = "ffmpeg -hide_banner";
wget    = "/usr/bin/wget --hsts-file=$CACHE/wget-hsts";   ## after implementing wget in roles/packages --config=$CONFIG/wget/wget.conf

};}
