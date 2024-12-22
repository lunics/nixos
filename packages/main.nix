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

bibata-cursors    # Open source, compact, and material designed cursor set

# k3s
kubectl
kustomize
kubie           # powerful alternative than kubectx and kubens
kubectx         # To switch between kubectl contexts and Kubernetes namespaces
kubecolor       # Colorize your kubectl output
stern           # Log tailing for Kubernetes
k9s
# kubelogin
# kubelogin-oidc
# kubeseal
# kubernetes-helm
# helm
# jq
# fluxcd
# fluxctl     ## replaced by fluxcd, A VERIFIER # controller for the GitOps Kubernetes operator flux, remplacé par la commande flux ???
# flux-bin      # permet d'installer flux sur le cluster et de modifier l'install
# age
# sops
# tilt
# unstable.kubernetes-polaris
# unstable.kubeshark
# unstable.k3d
# unstable.k9s
# unstable.teleport.client

# Used by scripts
pwgen
# coreutils   # to get: shuf

] ;}
