{ pkgs, ... }:{ programs.fzf = {

enable  = true;
package = pkgs.fzf;
defaultCommand = "fd --type f";
defaultOptions = [ "--layout reverse" "--height 40%" "--border" ];
enableZshIntegration = true;
tmux.shellIntegrationOptions = [ "-d 40%" ];
colors = ''
{
  bg    = "#1e1e1e";
  "bg+" = "#1e1e1e";
  fg    = "#d4d4d4";
  "fg+" = "#d4d4d4";
}
'';

# fileWidgetCommand
# fileWidgetOptions
# changeDirWidgetCommand
# changeDirWidgetOptions
# historyWidgetOptions

}; }
