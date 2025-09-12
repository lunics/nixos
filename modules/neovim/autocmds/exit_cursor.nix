{ 
  extraConfigLua = ''
  -- Prevent escape from moving the cursor one character to the left
  vim.cmd([[
    let CursorColumnI = 0
    autocmd InsertEnter * let CursorColumnI = col('.')
    autocmd CursorMovedI * let CursorColumnI = col('.')
    autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif ]])
  
  augroup('cursor', { clear = true, })
  
  autocmd('ExitPre', {
    group = 'cursor',
    command = 'set guicursor=a:ver90',
    desc = 'Set cursor back to beam when leaving Neovim', })
  '';
}
