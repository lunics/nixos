{ 
  extraConfigLua = ''
    augroup('YankHighlight', { clear = true })
    
    autocmd('TextYankPost', {
      group = 'YankHighlight',
      callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
      end
    })
  '';
}
