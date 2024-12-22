{ pkgs, inputs, ... }:{
# todo line 518 /h/l/d/r/nixos/official/nur-expressions/pkgs/firefox-addons/addons.json
                                            # TODO with pkgs.nur.repos.rycee.firefox-addons; [
programs.firefox.profiles.Lunics.extensions = with inputs.firefox-addons.packages.${pkgs.system}; [

# ublock-origin
profile-switcher
localcdn
behave
skip-redirect
consent-o-matic
# simple-tab-groups   # session manager alternative
istilldontcareaboutcookies
i-dont-care-about-cookies
ipvfoo

multi-account-containers
temporary-containers
tab-session-manager
auto-tab-discard
# open-url-in-container

# vimium
gesturefy
ghosttext
hover-zoom-plus
simple-translate
# immersive-translate
# gitako-github-file-tree

tabliss
# momentumdash

h264ify
videospeed
# jump-cutter
return-youtube-dislikes
# musescore-downloader

pipewire-screenaudio    # to connect webcall to pipewire

browserpass
passff

lovely-forks
refined-github

# keepa   amazon price traker
# darkreader
# omnivore

# tokyo-night-v2
# theme-nord-polar-night
# gruvbox-dark-theme
# gnome-shell-integration

# ipfs-companion
# simplelogin     # self-hostable email alias protection
# pushbullet
# joplin-web-clipper
# authenticator
# open tabs next to current
# wallabagger
# Bukubrow
# single-file
# hoppscotch        request API builder

];}
