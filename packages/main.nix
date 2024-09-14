{ pkgs, ... }:{ home.packages = with pkgs; [

neovim
lazygit
tmux
yazi
ueberzugpp
python3

# browsers
# librewolf
firefox
# tor-browser

lsd
eza
fzf
zoxide
bat
wget
fd

# archive
ouch
xarchiver


# screensharing
grim
jq
slurp

# media controls
playerctl

] ;}
