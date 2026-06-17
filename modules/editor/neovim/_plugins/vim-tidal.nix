{ pkgs, ... }:{
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname   = "vim-tidal";
      version = "2023-06-02";
      src     = pkgs.fetchFromGitHub {
        owner = "tidalcycles";
        repo  = "vim-tidal";
        rev   = "e440fe5bdfe07f805e21e6872099685d38e8b761";
        hash  = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
      };
    })
  ];
}
