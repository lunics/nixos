{ pkgs, inputs, ... }:{
# todo line 518 /h/l/d/r/nixos/official/nur-expressions/pkgs/firefox-addons/addons.json
                                            # TODO with pkgs.nur.repos.rycee.firefox-addons; [
programs.firefox.profiles.Lunics.extensions = with inputs.firefox-addons.packages.${pkgs.system}; [

# i ublock-origin
# i behave
# localcdn useless: Third parties are already partitioned if you use Total Cookie Protection (dFPI)
# i skip-redirect
# i consent-o-matic
# # simple-tab-groups   # session manager alternative
# i istilldontcareaboutcookies
# ipvfoo

# multi-account-containers
# temporary-containers
# i tab-session-manager
# auto-tab-discard
# # open-url-in-container

# i vimium
# gesturefy
# ghosttext
# i hover-zoom-plus
# i simple-translate
# # immersive-translate
# # gitako-github-file-tree

# i tabliss
# # momentumdash

# h264ify
# i videospeed
# # jump-cutter
# return-youtube-dislikes
# # musescore-downloader

# i pipewire-screenaudio    # to connect webcall to pipewire

# browserpass
# passff
keeper

# i lovely-forks
# refined-github

# # keepa   amazon price traker
# # darkreader
# # omnivore

# # tokyo-night-v2
# # theme-nord-polar-night
# # gruvbox-dark-theme
# # gnome-shell-integration

# # ipfs-companion
# # simplelogin     # self-hostable email alias protection
# # pushbullet
# # joplin-web-clipper
# # authenticator
# # open tabs next to current
# # wallabagger
# # Bukubrow
# # single-file
# # hoppscotch        request API builder

];}
