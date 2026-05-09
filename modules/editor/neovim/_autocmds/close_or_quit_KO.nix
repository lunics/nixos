{ 
  extraConfigLua = ''
    function! CloseOrQuit()
      if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        quit
      else
          bdelete
      endif
    endfunction
  '';
}
