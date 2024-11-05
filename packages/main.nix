{ pkgs, ... }:{ home.packages = with pkgs; [

neovim
lazygit
yazi
ueberzugpp
python3
tomb
sshfs

lsd
eza
fzf
zoxide
bat
ripgrep
entr    # permet de run des script automatiquement dans shell lorsque fichier source est modifier: ls *.rb | entr ruby main.rb
wget
fd
trash-cli

udiskie

comma   # to runs nix software without installing it

# archive
ouch
xarchiver


# screensharing
grim
jq
slurp

# media controls
playerctl

bibata-cursors    # Open source, compact, and material designed cursor set

] ;}
