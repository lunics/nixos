{ pkgs, inputs, ... }:{ home.packages = with pkgs; [

# neovim
inputs.nixvim.packages.x86_64-linux.default
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
entr        # permet de run des script automatiquement dans shell lorsque fichier source est modifier: ls *.rb | entr ruby main.rb
wget
fd
trash-cli

udiskie

htop
pciutils    # for lspci

comma       # to runs nix software without installing it

# archive
ouch
xarchiver

# HYPRLAND
# qt5   KO
# qt6   KO

# screensharing
grim
jq
slurp
# HYPRLAND

# media controls
playerctl
freetube
spotify

bibata-cursors    # Open source, compact, and material designed cursor set

] ;}
