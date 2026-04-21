
{ config, pkgs, ... }:{ 
  programs.zsh.zplug = {
    enable    = true;
    zplugHome = "${config.programs.zsh.dotDir}/zplug";
    package   = pkgs.zplug;
    plugins = [
    ethan605/fzfsh 
      Add fzf plugins for chezmoi, docker, git, kubectl and pass
    do-i-need-a-username/ensure-kube-context 
      Ensures that the --context flag is passed to various Kubernetes commands like kubectl, cilium, stern, and more.
    yzdann/kctl
      Add helper aliases for kubectl
      aug 2021


    kube-aliases - Adds functions and aliases to make working with kubectl more pleasant.
    kube-ps1 - ZSH plugin for kubectl that adds current context and namespace.
    kubecolor (devopstales) - Adds aliases for the kubecolor command.
    kubecolor (droctothorpe) - Simplify and colorize the output of kubectl get events -w
    kubecolor (trejo08) - Prints colorized outputs from kubectl. Includes helper functions.
    kubeconfig-mgr - Makes managing multiple kubeconfig files easier.
    kubectl-config-switcher - Switch between config files in ~/.kube via the KUBECTL environment variable.
    kubectl-prompt - Display information about the kubectl current context and namespace in your ZSH prompt. Creates ZSH_KUBECTL_CONTEXT, ZSH_KUBECTL_NAMESPACE,ZSH_KUBECTL_PROMPT and ZSH_KUBECTL_USER variables you can use to customize your prompt.
    kubectl - ZSH plugin for managing kubectl.
    kubectlenv - Easily switch between multiple kubectl versions.
    kubectx (ptavares) - Installs and loads kubectx.
    kubectx (unixorn) - Automatically installs kubectx and kubens.
    kubernetes - Add kubernetes helper functions and aliases.

      { name = "hlissner/zsh-autopair";              } # auto-add closing brackets, quotes, etc.
      { name = "jeffreytse/zsh-vi-mode";             } # Better than built‑in bindkey -v
      { name = "MichaelAquilina/zsh-you-should-use"; }
      { name = "changyuheng/zsh-interactive-cd";     }
    ];
  };
}
