{
  nix.gc = {
    automatic  = false;
    dates      = [ "weekly" ];
    options    = "";               # options given to nix-collect-garbage when runs automatically. ex "--max-freed $((64 * 1024**3))" 
    persistent = true;
    randomizedDelaySec = "0";
  };
}
