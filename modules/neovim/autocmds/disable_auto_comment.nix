{ 
  extraConfigLua = ''
    augroup('disableAutoComment', { clear = true, })
    
    autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile', }, {
      group   = 'disableAutoComment',
      pattern = '*',
      command = 'setlocal fo-=c fo-=r fo-=o fo+=t',
      desc    = 'Disable auto-commenting for all file types',
    })
  '';
}
