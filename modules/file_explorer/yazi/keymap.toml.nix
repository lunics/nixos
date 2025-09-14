{ config, ... }:
let
  _yazi = config._.yazi;
in {
  home.file.".config/yazi/keymap.toml".text = ''
    [mgr]
    keymap = [
      { on = ["<Esc>"], run = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
      { on = ["q"],     run = "quit",               desc = "Exit the process" },
      { on = ["Q"],     run = "quit --no-cwd-file", desc = "Exit the process without writing cwd-file" },
      { on = ["<C-q>"], run = "close",              desc = "Close the current tab, or quit if it is last tab" },
      { on = ["<C-z>"], run = "suspend",            desc = "Suspend the process" },
    
      # Navigation
      { on = ["${_yazi.up}"],   run = "arrow -1", desc = "Move cursor up" },
      { on = ["${_yazi.down}"], run = "arrow 1",  desc = "Move cursor down" },
      
      { on = ["${_yazi.scroll_up}"],     run = "seek -1" },
      { on = ["${_yazi.scroll_down}"],     run = "seek 1"  },
    
      { on = ["${_yazi.left}"],  run = ["leave", "escape --visual --select"], desc = "Go back to the parent directory" },
      # { on = ["l"],   run = ["enter", "escape --visual --select"], desc = "Enter the child directory" },
      { on = ["${_yazi.right}"], run = "plugin --sync smart-enter", desc = "Enter the subfolder faster, or open the file directly" },
    
      { on = ["H"],     run = "back",    desc = "Go back to the previous directory" },
      { on = ["L"],     run = "forward", desc = "Go forward to the next directory" },
    
      { on = ["<Up>"],    run = "arrow -1", desc = "Move cursor up" },
      { on = ["<Down>"],  run = "arrow 1",  desc = "Move cursor down" },
      { on = ["<Left>"],  run = "leave",    desc = "Go back to the parent directory" },
      { on = ["<Right>"], run = "enter",    desc = "Enter the child directory" },
    
      { on = ["g"],        run = "arrow -99999999", desc = "Move cursor to the top" },
      # { on = ["g", "g"], run = "arrow -99999999", desc = "Move cursor to the top" },
      { on = ["G"],        run = "arrow 99999999",  desc = "Move cursor to the bottom" },
    
      # Selection
      { on = ["<Space>"], run = ["select --state=none", "arrow 1"], desc = "Toggle the current selection state" },
      { on = ["v"],       run = "visual_mode",             desc = "Enter visual mode (selection mode)" },
      { on = ["V"],       run = "visual_mode --unset",     desc = "Enter visual mode (unset mode)" },
      { on = ["<C-a>"],   run = "select_all --state=true", desc = "Select all files" },
      { on = ["<C-r>"],   run = "select_all --state=none", desc = "Inverse selection of all files" },
    
      # Operation
      { on = ["<Enter>"], run = "open", desc = "Open the selected files" },
      # { on = ["<Enter>"], run = "open --interactive", desc = "Open the selected files interactively" },
      { on = ["y"], run = ["yank", "escape --visual --select"], desc = "Copy the selected files" },
      { on = ["Y"], run = ["unyank", "escape --visual --select"], desc = "Cancel the yank status of files" },
      { on = ["x"], run = ["yank --cut", "escape --visual --select"], desc = "Cut the selected files" },
      { on = ["X"], run = ["unyank", "escape --visual --select"], desc = "Cancel the yank status of files" },
      { on = ["p"], run = "paste", desc = "Paste the files" },
      { on = ["P"], run = "paste --force", desc = "Paste the files (overwrite if the destination exists)" },
      { on = ["-"], run = "link", desc = "Symlink the absolute path of files" },
      { on = ["_"], run = "link --relative", desc = "Symlink the relative path of files" },
      # { on = ["d"], run = "shell trash $files" },
      # { on = ["dy"], run = "remove --force", desc = "Cut the selected characters" },
      { on = ["d"], run = ["remove", "escape --visual --select"],               desc = "Move the files to the trash (bin/trash)" },
      { on = ["D"], run = ["remove --permanently", "escape --visual --select"], desc = "Permanently delete the files (rm -fr)" },
      { on = ["a"], run = "create", desc = "Create a file or directory (ends with / for directories)" },
      { on = ["A"], run = "create --dir", desc = "Create only a directory" },
      { on = ["${_yazi.rename}"], run = "rename --cursor=before_ext", desc = "Rename a file or directory" },
      { on = [";"], run = "shell", desc = "Run a shell command" },
      { on = [":"], run = "shell --block", desc = "Run a shell command (block the UI until the command finishes)" },
      { on = ["."], run = "hidden toggle", desc = "Toggle the visibility of hidden files" },
      # { on = ["s"], run = "search fd", desc = "Search files by name using fd" },
      # { on = ["S"], run = "search rg", desc = "Search files by content using ripgrep" },
      { on = ["<C-s>"], run = "search none", desc = "Cancel the ongoing search" },
      # { on = [ "z" ],         run = "jump zoxide",                                          desc = "Jump to a directory using zoxide" },
      { on = ["z", "u"], run = "shell --confirm 'ouch decompress $@'", desc = "Decompress" },
      { on = ["z", "d"], run = "shell --confirm 'ouch compress $@'", desc = "Compress" },
      { on = ["<Tab>"], run = "plugin fzf --args='fzf'", desc = "Jump to a directory, or reveal a file using fzf" },
      # { on = ["<Tab>"], run = "plugin fg --args='rg'", desc = "find file by content (ripgrep match)" },
    
      # Copy
      { on = ["c", "c"], run = "copy path", desc = "Copy the absolute path" },
      { on = ["c", "d"], run = "copy dirname", desc = "Copy the path of the parent directory" },
      { on = ["c", "f"], run = "copy filename", desc = "Copy the name of the file" },
      { on = ["c", "n"], run = "copy name_without_ext", desc = "Copy the name of the file without the extension" },
    
      # Filter
      { on = ["<C-f>"], run = "filter --smart", desc = "Filter the files" },
    
      # Find
      # { on = ["s"], run = "find --smart", desc = "Find next file" },
      { on = ["/"], run = "find --smart", desc = "Find next file" },
      # { on = ["S"], run = "find --previous --smart", desc = "Find previous file" },
      { on = ["?"], run = "find --previous --smart", desc = "Find previous file" },
      { on = ["n"], run = "find_arrow", desc = "Go to next found file" },
      { on = ["N"], run = "find_arrow --previous", desc = "Go to previous found file" },
    
      { on = ["b"],     run = "toggle status"  },
    
      { on = ["~"], run = "help", desc = "Open help" },
    ]
    
    [[mgr.prepend_keymap]]      # dropping to the shell
    on   = "s"
    for  = "unix"
    run  = 'shell "$SHELL" --block'
    desc = "Open $SHELL here"
    
    [[mgr.prepend_keymap]]      # copy selected files to the system clipboard while yanking
    on  = "y"
    run = [ 'shell -- for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list', "yank" ]
    
    [[input.prepend_keymap]]    # Close input by once Esc press
    on   = "<Esc>"
    run  = "close"
    desc = "Cancel input"

    "$schema" = "https://yazi-rs.github.io/schemas/keymap.json"     # toml linter to validate your config.
  '';
}
