{
  home.file.".config/yazi/yazi.toml".text = ''
    [mgr]
    linemode        = "none"
    mouse_events    = ["click", "scroll"]
    ratio           = [2, 3, 6]
    scrolloff       = 5
    title_format    = ""
    show_hidden     = false
    show_symlink    = true
    # symlink         = { fg = "cyan", modifiers = ["bold"] } KO
    # symlink_broken  = { fg = "red",  modifiers = ["bold"] } KO
    sort_by         = "alphabetical"    # alphabetical, mtime, size, ctime
    sort_dir_first  = true
    sort_reverse    = false
    sort_sensitive  = false
    sort_translit   = false
    
    [preview]
    cache_dir       = ""
    image_delay     = 30
    image_filter    = "triangle"
    image_quality   = 75
    max_height      = 900
    max_width       = 600
    sixel_fraction  = 15
    tab_size        = 2
    ueberzug_offset = [0, 0, 0, 0]
    ueberzug_scale  = 1
    wrap            = "no"

    [statusline]
    enabled         = false
    
    [opener]
    edit = [
      { run = '[ -n "$EDITOR" ] && $EDITOR "$@"', desc = "$EDITOR", block = true },
    ]
    open = [
      { run = 'setsid xdg-open "$@"', desc = "Open" },
      { run = 'setsid okular "$@"', orphan = true, desc = "Okular" },
    ]
    reveal = [
      { run = "exiftool \"$1\"; echo \"Press enter to exit\"; read", block = true, desc = "Show EXIF" },
    ]
    extract = [
      { run = 'ouch decompress "$1"', desc = "Extract here" },
    ]
    play = [
      { run = 'xdg-open "$@"', orphan = true },
      { run = 'vlc "$@"', orphan = true, desc = "VLC" },
      { run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read", block = true, desc = "Show media info" },
    ]
    
    [tasks]
    micro_workers    = 10
    macro_workers    = 25
    bizarre_retry    = 5
    image_alloc      = 536870912
    image_bound      = [0, 0]
    suppress_preload = false
    
    [log]
    enabled = false
    
    "$schema"       = "https://yazi-rs.github.io/schemas/yazi.json"
  '';
}
