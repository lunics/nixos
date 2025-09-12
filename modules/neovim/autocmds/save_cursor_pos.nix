{ 
  extraConfigLua = ''
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    
    augroup('view', { clear = true, })
    
    autocmd({ 'BufWinLeave', }, {
      group   = 'view',
      pattern = '*.*',
      command = 'mkview',
      desc    = 'Save cursor position and folds when leaving a buffer',
    })
    
    autocmd({ 'BufWinEnter', }, {
      group   = 'view',
      pattern = '*.*',
      command = 'silent! loadview',
      desc    = 'Restore cursor position and folds when entering a buffer',
    })
  '';
}
