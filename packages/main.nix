{ pkgs, ... }:{ home.packages = with pkgs; [

neovim
lazygit
tmux
yazi
ueberzugpp
python3

lsd
eza
fzf
zoxide
bat
ripgrep
entr    # permet de run des script automatiquement dans shell lorsque fichier source est modifier: ls *.rb | entr ruby main.rb
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
