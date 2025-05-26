{ config, ... }:{ 
  home.sessionVariables = rec {
    # APPS
    TERMINAL      = "alacritty";
    EDITOR        = "nvim";
    MANPAGER      = "nvim +Man!";
    READER        = "zathura";
    BROWSER       = "firefox";
    FILE_EXPLORER = "yazi";
    
    # XDG
    XDG_CONFIG_HOME       = "${config.home.homeDirectory}/.config";
    XDG_CONFIG_DIRS       = "/etc/xdg";
    XDG_CACHE_HOME        = "${config.home.homeDirectory}/.cache";
    XDG_DATA_HOME         = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME        = "${config.home.homeDirectory}/.local/state";
    XDG_BIN_HOME          = "${config.home.homeDirectory}/.local/bin";
    # XDG_DATA_DIRS         = "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share";
    XDG_DESKTOP_DIR       = "$HOME/desktop";
    XDG_DOCUMENTS_DIR     = "$HOME/documents";
    XDG_DOWNLOAD_DIR      = "$HOME/downloads";
    XDG_MUSIC_DIR         = "$HOME/music";
    XDG_PICTURES_DIR      = "$HOME/pictures";
    XDG_PUBLICSHARE_DIR   = "$HOME/public";
    XDG_TEMPLATES_DIR     = "$HOME/templates";
    XDG_VIDEOS_DIR        = "$HOME/videos";
    XDG_CURRENT_DESKTOP   = "Hyprland";
    XDG_SESSION_DESKTOP   = "Hyprland";
    XDG_SESSION_TYPE      = "wayland";
    XDG_SCREENSHOTS_DIR   = "$HOME/screenshots";
    CLUTTER_BACKEND       = "wayland";
    
    # PATH
    CONFIG          = "$XDG_CONFIG_HOME";
    # SHELLRC         = "$HOME/{{ path3.shell   }}";
    LOCAL           = "$HOME/.local";
    CACHE           = "$HOME/.cache";
    # SCRIPTS         = "$HOME/{{ path3.scripts }}";
    BIN             = "$HOME/.local/bin";
    SSH             = "$HOME/.config/ssh";
    # SSH_CONFIG    = "$SSH/config";
    SHARE           = "$LOCAL/share";
    CLOUD           = "$HOME/usb_copy";
    USB             = "/run/media/$USER";
    DOWNLOADS       = "~/downloads";
    LINUX           = "$CLOUD/linux";
    HOMELAB         = "$CLOUD/homelab";
    ANSIBLE         = "$HOMELAB/ansible";
    ANSIBLE_CONFIG  = "$ANSIBLE/ansible.cfg";
    GALAXY          = "$ANSIBLE/galaxy";
    FUNCTIONS       = "$SHELLRC/functions";
    KUBERNETES      = "$LINUX/kubernetes";
    # KUBECONFIG      = "$CONFIG/k3s/k3s.yaml";  # KO, why ?
    KUBECONFIG      = "$HOME/.config/k3s/k3s.yaml";
    # PATH           = "$PATH:$BIN";    # not compliant for nixos bin scripts
    
    USB_ID          = "0543f662-b81a-484e-9c52-71b6142685b2";
    OPENAI_API_KEY  = "***REMOVED***";
    
    # ZSH
    # ZSHRC       = "$SHELLRC/zsh";           # personnal
    # ZDOTDIR     = "$ZSHRC";                 # official
    # # ZSH_THEME = "robbyrussell";
    WORDCHARS   = "*?_-[]~=&;!#$%^(){}<>";   # special characters considered as normal letters
    # KEYTIMEOUT  = 0.1;                      # time to activate vim mode and others mode, ## tester sans
    # ZPLUG_HOME  = "$ZSHRC/zplug";           # zplug home dir
    # ZSH_FZF_HISTORY_SEARCH_BIND = "^r";     # set keybinding for zsh-fzf-history-search plugin
    # CASE_SENSITIVE:     "true"
    # HYPHEN_INSENSITIVE: "true"          # Case-sensitive completion must be off. _ and - will be interchangeable
    # DISABLE_AUTO_TITLE: "true"          # auto-setting terminal title
    # ENABLE_CORRECTION:  "true"          # command auto-correction

    _ZO_DATA_DIR = "$HOME/usb_copy/homelab/share/zoxide";
    
    # # GUI
    #   name:       gui
    #   WM:         "{{ window_manager | default('') }}"
    #   STATUSBAR:  "{{ status_bar     | default('') }}"
    #   XAUTHORITY: "$HOME/{{ path3.xorg }}/xauthority"
    #   XINITRC:    $CONFIG/xorg/xinitrc
    #   SWAYSOCK:   "$(bash -c 'ls /run/user/{{ default_user }}/sway-ipc.* 2> /dev/null | head -n 1')"
    #
    #
    # # OTHERS
    #   name:                 others
    #   PAGER: bat
    #   FZF_DEFAULT_OPTS: --layout=reverse --height 40%
    #   FZF_COMPLETION_TRIGGER: "**"       # ssh **<TAB>, kill -9 **<TAB>
    #   TMUXINATOR_CONFIG: $CONFIG/tmux
    #   TMUX_TMPDIR: $XDG_RUNTIME_DIR ## ??
    #   LYNX_CFG:   $CONFIG/lynx/lynx.cfg
    #   LYNX_LSS:   $CONFIG/lynx/lynx.lss
    #   JOPLIN: /usr/bin/joplin
    #   TIMEWARRIORDB: "$HOME/{{ path2.share_cloud }}/timewarrior"
    #   NPM_CONFIG_GLOBALCONFIG: "$HOME/{{ path2.config }}/npm/npm_global.conf"
    #   NPM_CONFIG_USERCONFIG:   "$HOME/{{ path2.config }}/npm/npm_user.conf"
    #   PNPM_HOME:               "$HOME/{{ path3.share }}/pnpm"
    #   STARSHIP_CONFIG: $CONFIG/starship/config.toml
    #   STARSHIP_CACHE:  $CACHE/starship
    #   WEECHAT_HOME:    $CONFIG/weechat
    #   WEECHAT_EXTRA_LIBDIR: $CONFIG/weechat/plugins
    #
    #   EMAIL:        ***REMOVED***
    #   GMAIL:        ***REMOVED***
    #   ARCH_SOURCES: /home/$USER/arch_sources
    #   # WGETRC:       $CONFIG/wget/wgetrc                 ## réactiver une fois qu'il existera vraiment
    #   ## VOIR SON UTILITE SUR LARBS
    #   ## https://linuxfr.org/users/perdu/journaux/faire-de-la-magie-avec-son-inputrc
    #   INPUTRC:      $CONFIG/shell/inputrc
    #   KEYCHAIN:     0
    #
    #   # LARBS que j'ai modifié
    #   #v1 PATH: "$PATH:${$(/usr/bin/find ~/.local/bin -type d -printf %p:)%%:}"            # Adds `~/.local/bin` to $PATH
    #   #v2 PATH: "${$(/usr/bin/find ~/.local/bin -type d -printf %p:)%%:}:$PATH"            # Adds `~/.local/bin` to $PATH
    #   # PATH:           "${$(/usr/bin/find {{ path_local }}/bin -type d -printf %p:)%%:}:$PATH"            # Adds `~/.local/bin` to $PATH
    #   # PATH:           $BIN:$PNPM_HOME:/usr/local/bin:$PATH
    #   PATH:           $SCRIPTS:$BIN:$PNPM_HOME:$PATH
    #   NOTMUCH_CONFIG: $CONFIG/notmuch-config
    #
    #   GTK2_RC_FILES:  $CONFIG/gtk/2/settings.ini
    #   # GTK2_RC_FILES:  $CONFIG/gtk/2/gtkrc
    #   # GTK3_RC_FILES:  $CONFIG/gtk/3/settings.ini      ## A TESTER, je pense que cette var n'existe plus en 3.0
    #   # GTK4_RC_FILES:  $CONFIG/gtk-4.0/settings.ini    ## A TESTER
    #   # GTK_THEME:      Adwaita:dark                    # a activer au choix
    #
    #   LESSHISTFILE:   "-"
    #   WINEPREFIX:     $SHARE/wineprefixes/default
    #   KODI_DATA:      $SHARE/kodi
    #   ANDROID_SDK_HOME: $CONFIG/android
    #   CARGO_HOME:     $SHARE/cargo
    #   GOPATH:         $SHARE/go
    #   UNISON:         $SHARE/unison
    #   HISTFILE:       $SHARE/history
    #   AUTOJUMP_ERROR_PATH: "{{ path2.share_cloud }}/autojump"
    #   # ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
    #
    #
    #   # Other program settings:
    #   DICS: /usr/share/stardict/dic/
    #   SUDO_ASKPASS: $LOCAL/bin/dmenupass
    #   # LESS: "-g -F -i -M -R -S -w -X -z-4"  ## semble KO, a retester
    #   # LESS: "+GgFiMRSwX"    ## KO, casse /usr/bin/bat
    #   ## caractère spécial à corriger avec la bonne font
    #   # LESS_TERMCAP_mb: "$(printf '%b' 'CARACTERE_SPECIAL[1;31m')"
    #   # LESS_TERMCAP_md: "$(printf '%b' 'CARACTERE_SPECIAL[1;36m')"
    #   # LESS_TERMCAP_me: "$(printf '%b' 'CARACTERE_SPECIAL[0m')"
    #   # LESS_TERMCAP_so: "$(printf '%b' 'CARACTERE_SPECIAL[01;44;33m')"
    #   # LESS_TERMCAP_se: "$(printf '%b' 'CARACTERE_SPECIAL[0m')"
    #   # LESS_TERMCAP_us: "$(printf '%b' 'CARACTERE_SPECIAL[1;32m')"
    #   # LESS_TERMCAP_ue: "$(printf '%b' 'CARACTERE_SPECIAL[0m')"
    #   LESS_TERMCAP_mb: ""
    #   LESS_TERMCAP_md: ""
    #   LESS_TERMCAP_me: ""
    #   LESS_TERMCAP_so: ""
    #   LESS_TERMCAP_se: ""
    #   LESS_TERMCAP_us: ""
    #   LESS_TERMCAP_ue: ""
    #   LESSOPEN: "| /usr/bin/highlight -O ansi %s 2>/dev/null"
    #   QT_QPA_PLATFORMTHEME: "gtk2"      # Have QT use gtk2 theme.
    #   MOZ_USE_XINPUT2: "1"              # Mozilla smooth scrolling/touchpads.
    #   AWT_TOOLKIT: "MToolkit wmname LG3D"       #May have to install wmname
    #   _JAVA_AWT_WM_NONREPARENTING: 1    # Fix for Java applications in dwm
  };
}
