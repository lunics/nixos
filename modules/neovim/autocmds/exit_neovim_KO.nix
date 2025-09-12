{ 
  # :autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif
  extraConfigLua = ''
    autocmd({ "BufLeave", }, {
      group   = "view",
      pattern = "*.*",
      command = "if len(getbufinfo({'buflisted':1})) > 1 | map q :wqall <CR> | endif",
      desc    = "Save cursor position and folds when leaving a buffer",
    })
  '';
}
