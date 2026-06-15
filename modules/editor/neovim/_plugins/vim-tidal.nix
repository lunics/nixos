{ pkgs, ... }:{
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname    = "vim-tidal";
      version  = "1.4.8";
      src      = pkgs.fetchFromGitHub {
        owner  = "tidalcycles";
        repo   = "vim-tidal";
        rev    = "e440fe5bdfe07f805e21e6872099685d38e8b761";
        sha256 = "1g9rljxznjlr4zpn0p0y838s1dr38maggdh9yi8cl9izxgvsypbk";
      }; 
    }) 
  ];

  # extraConfigLua = ''
  #   require("vim-tidal").setup {
  #   }
  # '';
}
