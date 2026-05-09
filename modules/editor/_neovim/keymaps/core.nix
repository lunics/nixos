{ _config, ... }:let
  _map = _config._.neovim.keymap;
in {
  extraConfigLua = ''
    local map   = vim.keymap.set
    local opts1 = { noremap = true }
    local opts2 = { noremap = true, silent = true }
    local opts3 = { noremap = true, silent = true, nowait = true }
    
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- disable mapped arrow
    -- map({'n','v'}, '${_map.left}',    '<Nop>',    opts1)
    -- map({'n','v'}, '${_map.down}',    '<Nop>',    opts1)
    -- map({'n','v'}, '${_map.up}',      '<Nop>',    opts1)
    -- map({'n','v'}, '${_map.right}',   '<Nop>',    opts1)
    -- map({'n','v'}, '${_map.insert}',  '<Nop>',    opts1)
    -- map({'n','v'}, '${_map.replace}', '<Nop>',    opts1)
    -- map({"n","i"}, "${_map.undo}",    "<Nop>",    opts1)
    -- map({"n","i"}, "${_map.redo}",    "<Nop>",    opts1)
    
    -- remap mapped arrow
    map({'n','v'}, '${_map.left}',    '<Left>',   opts1)
    map({'n','v'}, '${_map.down}',    '<Down>',   opts1)
    map({'n','v'}, '${_map.up}',      '<Up>',     opts1)
    map({'n','v'}, '${_map.right}',   '<Right>',  opts1)

    map('n',       '${_map.undo}',    '<Cmd>undo<CR>', opts2)
    map('n',       '${_map.redo}',    '<Cmd>redo<CR>', opts2)
    -- map('n',       '${_map.undo}',    ':undo <CR>', opts2)
    -- map('i',    '<C-z>',           '<C-o>u',     opts2) -- undo without leaving insert
    -- map('n',       '${_map.redo}',    ':redo <CR>', opts2)
    -- map('i',    '<C-S-z>',         '<C-o><C-r>', opts2) -- redo //

    map('n',       '${_map.insert}',  ':startinsert <CR>', opts2) -- insert key
    map('n',       '${_map.replace}', 'r',                 opts1) -- replace key

    map("n",       "<C-${_map.up}>",   "<C-y>",      opts1)  -- scroll up   in normal mode
    map("n",       "<C-${_map.down}>", "<C-e>",      opts1)  -- scroll down in normal mode
    map("i",       "<C-${_map.up}>",   "<C-x><C-y>", opts1)  -- scroll up   in insert mode
    map("i",       "<C-${_map.down}>", "<C-x><C-e>", opts1)  -- scroll dowb in insert mode
    map("n", "<PageUp>"  ,  "<C-y>")                  -- PageUp   = scroll up   1 line
    map("n", "<PageDown>",  "<C-e>")                  -- PageDown = scroll down 1 line
    map("i", "<PageUp>"  ,  "<C-x><C-y>", opts1)   -- //
    map("i", "<PageDown>",  "<C-x><C-e>", opts1)   -- //

    -- map("n", "q",           ":call CloseOrQuit()<CR> zz")           -- close buffer 
    -- map("n", "Q",           ":wqall! <CR>")        -- q or Q is considered as same Q
    -- map("i", "<C-q>",       "<Esc> :qa <CR>")       -- quit from insert mode
    map("n", "<C-q>",       ":wqa <CR>")              -- quit from insert mode
    -- map("n", "<S-q>",       ":wqa <CR>")            -- quit from normal mode
    map("n", "<C-w>",       ":bd <CR> zz")            -- close buffer
    map("i", "<C-w> <Esc>", ":bd <CR> zz")            -- close buffer
  ''; 
}
