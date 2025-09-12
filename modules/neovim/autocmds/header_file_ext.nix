{ 
  extraConfigLua = ''
    -- header template for each new file .sh
    autocmd(
      "BufNewFile", {
        pattern = "*.sh",
        command = ":0r!echo \\\\#\\!/usr/bin/env bash"
      }
    )
    
    -- header template for each new file .py
    autocmd(
      "BufNewFile", {
        pattern = "*.py",
        command = ":0r!echo \\\\#\\!/usr/bin/env python3"
      }
    )
  '';
}
