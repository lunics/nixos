{
  nix.gc = {
    automatic          = true;
    dates              = [ "weekly" ];
    persistent         = true;
    options            = "";   # "--max-freed $((64 * 1024**3))"
    randomizedDelaySec = "0";
  };
}
