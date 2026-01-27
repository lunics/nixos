{ config, pkgs, ... }:
let
  script_overlay = self: super: {
    commit-git-flake = super.writeShellApplication {
      name = "commit-git-flake";

      excludeShellChecks = [ "SC2086" "SC2046" "SC1091" ];
    
      text = ''
        flake_dir=${config._.flake_dir}
        module=$1       # null, system or home
        git_pop=0
        
        cd $flake_dir
    
        if [[ -n "$module" ]]; then
          module_branch=$(cd $flake_dir/../$module && git rev-parse --abbrev-ref HEAD)
        fi
        
        git checkout -b flake || git checkout flake
        git add flake.lock
        git commit -m "update all inputs"
    
        if [[ -z "$module" ]]; then
          git commit -m "update $module, $module_branch"
        else
          git commit -m "update all inputs"
        fi
    
        git checkout main
        
        if (! git diff --quiet) || [ "$(git ls-files --others --exclude-standard)" != "" ]; then
          git stash -m "autostash $(date +'%H:%M:%S %d/%m/%Y')"
          git_pop=1
        fi
        
        git rebase flake
        git branch -D flake
        
        if ((git_pop)); then
          git stash pop 0
        fi
      '';
    };
  };
in {
  nixpkgs.overlays = [ script_overlay ];

  home.packages = [ pkgs.commit-git-flake ];
}
