{ pkgs, inputs, ... }:{ home.packages = with pkgs; [

inputs.flake-neovim.packages.x86_64-linux.default
lazygit
yazi
ueberzugpp
python3
tomb
sshfs
go-task         # taskfile
wl-clipboard
# clipboard-jh    # best wayland clipboard

lsd
eza
fzf
zoxide
bat
ripgrep
entr            # permet de run des script automatiquement dans shell lorsque fichier source est modifier: ls *.rb | entr ruby main.rb wget
fd
trash-cli

udiskie

htop
pciutils          # for lspci
usbutils          # for lsusb

comma             # to runs nix software without installing it
nix-search-cli    # CLI for searching packages on search.nixos.org

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
streamlink-twitch-gui-bin
vlc

bibata-cursors    # Open source, compact, and material designed cursor set

# Used by scripts
pwgen
# coreutils   # to get: shuf

sqlite
psmisc        # to get: fuser (to unlock sqlite db)

] ;}
