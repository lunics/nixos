{
  enable = true;

  opts = {
    backup              = false   ; # creates a backup file
    title               = true    ;
    background          = "dark"  ;
    termguicolors       = true    ;
    showmode            = false   ; # show/hide modes INSERT, NORMAL, VISUAL...
    ruler               = false   ; # show the line and column number of the cursor position
    laststatus          = 0       ;
    showcmd             = false   ;
    cursorline          = true    ; # highlight the current line
    mouse               = "a"     ; # allow the mouse to be used in neovim
    undofile            = true    ; # enable persistent undo
    updatetime          = 300     ; # faster completion (4000ms default)
    hlsearch            = false   ; # highlight/hide all matches on previous search pattern
    compatible          = false   ;
    number              = true    ; # set numbered lines
    relativenumber      = true    ;
    numberwidth         = 4       ; # set number column width to 2 {default 4}
    signcolumn          = "no"    ; # yes = always show the sign column on the left, otherwise it would shift the text each time
    wrap                = false   ; # display lines as one long line
    linebreak           = true    ; # companion to wrap, don't split words
    scrolloff           = 0       ; # minimal number of screen lines to keep above and below the cursor
    sidescrolloff       = 4       ; # minimal number of screen columns either side of cursor if wrap is `false`
    cmdheight           = 2       ; # more space in the neovim command line for displaying messages
    tabstop             = 2       ; # insert 2 spaces for a tab
    showtabline         = 2       ; # always show tabs
    shiftwidth          = 2       ; # the number of spaces inserted for each indentation
    softtabstop         = 2       ;
    expandtab           = true    ; # convert tabs to spaces
    autoread            = true    ; # auto reload file when changes
    startofline         = true    ; # keep previous cursor position when open file, works only with sessions
    swapfile            = false   ; # not usefull when files are autosaved
    ignorecase          = true    ;
    smartcase           = false   ; # true=not working properly
    smartindent         = true    ;
    encoding            = "utf-8" ; # change the output encoding of the terminal for the read file
    fileencoding        = "utf-8" ; # change the output encoding of the file that is written
    splitbelow          = true    ; # force all horizontal splits to go below current window
    splitright          = true    ; # force all vertical splits to go to the right of current window
    conceallevel        = 0       ; # so that `` is visible in markdown files
    pumheight           = 10      ; # pop up menu height
    timeoutlen          = 250     ; # time to wait for a mapped sequence to complete (in milliseconds)
    # whichwrap         = "bs<>[]hl",  -- allow j and k to travel to prev/next line
    completeopt         = [ "menuone" "noselect" ];       # mostly just for cmp
    backspace           = [ "indent" "eol" "start"];
    wildmode            = [ "longest" "list" "full" ];    # Enable autocompletion
    clipboard           = "unnamed,unnamedplus";          # unnamedplus = allows neovim to access the system clipboard
    # iskeyword         = o.iskeyword + "-",              #  hyphenated words recognized by searches and not as a separator
    # shortmess         = o.shortmess + "c"               #  don't give |ins-completion-menu| messages
  };
}
