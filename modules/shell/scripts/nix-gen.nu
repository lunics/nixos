#!/usr/bin/env nu

def "nu-complete profiles" [] { ["hm", "nixos"] }

# List the "<prefix>-N-link" generations of a nix profile directory, newest first.
def list-gens [dir: string, prefix: string] {
  if not ($dir | path exists) {
    error make --unspanned { msg: $"no profile directory: ($dir)" }
  }

  let gens = (
    ls --long $dir
    | where name =~ $'($prefix)-\d+-link$'
    | insert id { $in.name | path basename | str replace $'($prefix)-' '' | str replace '-link' '' | into int }
    | select id modified target
    | sort-by id --reverse
  )

  if ($gens | is-empty) {
    error make --unspanned { msg: $"no ($prefix) generation found in ($dir)" }
  }

  $gens
}

# Show the generations in fzf, return the picked {id, target} or null if cancelled.
def pick-gen [gens: table, current: string, header: string] {
  let rows = (
    $gens | each {|g|
      let mark = if $g.target == $current { "*" } else { " " }
      $"($mark) ($g.id)\t($g.modified | format date '%Y-%m-%d %H:%M')\t($g.id)\t($g.target)"
    }
  )

  let sel = (
    $rows
    | str join "\n"
    | ^fzf --height 40% --reverse --no-multi --delimiter "\t" --with-nth "1,2" --header $header
    | complete
  )

  if $sel.exit_code != 0 or ($sel.stdout | str trim | is-empty) {
    return null
  }

  let fields = ($sel.stdout | str trim | split row "\t")
  { id: ($fields | get 2 | into int), target: ($fields | get 3) }
}

def switch-hm [] {
  let state = if ($env.XDG_STATE_HOME? | is-not-empty) {
    $env.XDG_STATE_HOME | path join "nix" "profiles"
  } else {
    $env.HOME | path join ".local" "state" "nix" "profiles"
  }

  # home-manager >= 22.11 keeps its profile under XDG_STATE_HOME, older ones in /nix/var
  let dir = if ($state | path join "home-manager" | path exists) {
    $state
  } else {
    $"/nix/var/nix/profiles/per-user/($env.USER)"
  }

  let current = ($dir | path join "home-manager" | path expand)
  let gen = (pick-gen (list-gens $dir "home-manager") $current "home-manager generations (* = current)")

  if $gen == null { return }

  let activate = ($gen.target | path join "activate")
  if not ($activate | path exists) {
    error make --unspanned { msg: $"no activate script in ($gen.target)" }
  }

  print $"activating home-manager generation ($gen.id)"
  ^$activate
}

def switch-nixos [] {
  let dir = "/nix/var/nix/profiles"
  let current = ($dir | path join "system" | path expand)
  let gen = (pick-gen (list-gens $dir "system") $current "NixOS generations (* = current)")

  if $gen == null { return }

  # same two steps as nixos-rebuild --switch-generation: move the profile, then activate it
  print $"switching to NixOS generation ($gen.id)"
  ^sudo nix-env --profile $"($dir)/system" --switch-generation $"($gen.id)"
  ^sudo $"($dir)/system/bin/switch-to-configuration" switch
}

# Pick a home-manager or NixOS generation with fzf and switch to it.
def main [profile: string@"nu-complete profiles" = "hm"] {
  match $profile {
    "hm" => (switch-hm)
    "nixos" => (switch-nixos)
    _ => (error make --unspanned { msg: $"unknown profile '($profile)': expected 'hm' or 'nixos'" })
  }
}
