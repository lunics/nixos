{ pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    sc-im
  ];

  # xdg.configFile."sc-im/scimrc".text = ''
  #   set autocalc
  # '';
}
  #   set autobackup=0
  #   set copy_to_clipboard_delimited_tab=1
  #   set autowrap=0
  #   set command_timeout=3000
  #   set debug=0
  #   set default_open_file_under_cursor_cmd=scopen
  #   set exec_lua=1
  #   set external_functions=0
  #   set filename_with_mode=0
  #   set half_page_scroll=1
  #   set help=0
  #   set ignorecase=0
  #   set import_delimited_as_text=0
  #   set input_bar_bottom=0
  #   set mapping_timeout=1500
  #   set newline_action=0
  #   set nocurses=0
  #   set numeric=0
  #   set numeric_decimal=1
  #   set numeric_zero=1
  #   set overlap=0
  #   set quiet=0
  #   set quit_afterload=0
  #   set tm_gmtoff=7200
  #   set trigger=1
  #   set truncate=0
  #   set underline_grid=0
  #   set xlsx_readformulas=0
  #   set default_copy_to_clipboard_cmd=xclip -i -selection clipboard <
  #   set default_paste_from_clipboard_cmd=xclip -o -selection clipboard
  # '';
