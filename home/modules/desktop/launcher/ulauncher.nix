{ pkgs, ... }:{
  home.packages = with pkgs; [ 
    ulauncher
    wmctrl        # ulauncher dep for mouse mgmt
  ];
  
  # ulauncher plugins
  # https://github.com/iboyperson/ulauncher-system
  # https://github.com/friday/ulauncher-clipboard
  # https://github.com/Ulauncher/ulauncher-emoji
  # https://github.com/hillaryychan/ulauncher-fzf
  # https://github.com/Eckhoff42/Ulauncher-Bluetooth-quick-connect
  # https://github.com/Ulauncher/ulauncher-kill
  # https://github.com/brpaz/ulauncher-brotab
  # https://github.com/the-lay/ulauncher-spotify-api
  # https://github.com/ulauncher/ulauncher-timer
  # https://github.com/melianmiko/ulauncher-nmcli
  # https://github.com/Rapha149/ulauncher-deepl
  # https://github.com/yannishuber/pass-ulauncher
  # https://github.com/KuenzelIT/ulauncher-firefox-bookmarks
  # https://github.com/NastuzziSamy/ulauncher-youtube-search
  # https://github.com/zensoup/ulauncher-unicode
  # https://github.com/mikebarkmin/ulauncher-duckduckgo
  # https://github.com/noam09/ulauncher-remmina
  # https://github.com/dhelmr/ulauncher-tldr
  # https://github.com/caraterra/pass-otp-for-ulauncher
  # https://github.com/episode6/ulauncher-system-management-direct
  # https://github.com/matheusfillipe/joplin-snippets
}
