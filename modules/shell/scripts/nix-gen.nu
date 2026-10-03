#!/usr/bin/env nu

def "nu-complete profiles" [] { ["hm", "nixos"] }

# home-manager >= 22.11 keeps its profile under XDG_STATE_HOME, older ones in /nix/var
def hm-profile-dir [] {
  let state = if ($env.XDG_STATE_HOME? | is-not-empty) {
    $env.XDG_STATE_HOME | path join "nix" "profiles"
  } else {
    $env.HOME | path join ".local" "state" "nix" "profiles"
  }

  if ($state | path join "home-manager" | path exists) {
    $state
  } else {
    $"/nix/var/nix/profiles/per-user/($env.USER)"
  }
}

# Where a profile lives, whether touching it needs root and owns boot entries.
def profile-info [profile: string] {
  match $profile {
    "hm" => ({ dir: (hm-profile-dir), name: "home-manager", label: "home-manager", sudo: false, boot: false })
    "nixos" => ({ dir: "/nix/var/nix/profiles", name: "system", label: "NixOS", sudo: true, boot: true })
    _ => (error make --unspanned { msg: $"unknown profile '($profile)': expected 'hm' or 'nixos'" })
  }
}

# List the "<name>-N-link" generations of a profile directory, newest first.
def list-gens [p: record] {
  if not ($p.dir | path exists) {
    error make --unspanned { msg: $"no profile directory: ($p.dir)" }
  }

  let gens = (
    ls --long $p.dir
    | where name =~ $'($p.name)-\d+-link$'
    | insert id { $in.name | path basename | str replace $'($p.name)-' '' | str replace '-link' '' | into int }
    | select id modified target
    | sort-by id --reverse
  )

  if ($gens | is-empty) {
    error make --unspanned { msg: $"no ($p.label) generation found in ($p.dir)" }
  }

  $gens
}

# Current generation id, read from the profile symlink. Comparing store paths instead
# would mark several rows, since a rollback points a new generation at an older path.
def current-id [p: record] {
  if not ($p.dir | path exists) { return null }

  let link = (ls --long $p.dir | where {|r| ($r.name | path basename) == $p.name })
  if ($link | is-empty) { return null }

  let base = ($link | get 0.target | path basename)
  if not ($base =~ $'^($p.name)-\d+-link$') { return null }

  $base | str replace $'($p.name)-' '' | str replace '-link' '' | into int
}

# One tab separated row per generation: id, current marker, date.
def gen-rows [profile: string] {
  let p = (profile-info $profile)
  let gens = (list-gens $p)
  let current = (current-id $p)

  $gens
  | each {|g|
      let mark = if $g.id == $current { "*" } else { " " }
      $"($g.id)\t($mark)\t($g.modified | format date '%Y-%m-%d %H:%M')"
    }
  | str join "\n"
}

# Drop a generation, after confirmation. Called back from the fzf binding.
def delete-gen [profile: string, id: int] {
  let p = (profile-info $profile)
  let gen = (list-gens $p | where id == $id)

  if ($gen | is-empty) {
    print $"generation ($id) not found"
    return
  }

  if $id == (current-id $p) {
    print $"refusing to delete generation ($id): it is the current one"
    return
  }

  let answer = (input $"delete ($p.label) generation ($id)? [y/N] ")
  if ($answer | str lowercase | str trim) != "y" { return }

  let target = ($p.dir | path join $p.name)
  if $p.sudo {
    ^sudo nix-env --profile $target --delete-generations $"($id)"
  } else {
    ^nix-env --profile $target --delete-generations $"($id)"
  }

  # a deleted generation stays in the boot menu until the bootloader is rebuilt
  if $p.boot {
    print "rebuilding the boot entries"
    ^sudo $"($target)/bin/switch-to-configuration" boot
  }
}

# Show the generations in fzf, return the picked id or null if cancelled.
def pick-gen [profile: string] {
  let p = (profile-info $profile)
  let self = $"'($nu.current-exe)' '($env.CURRENT_FILE)'"

  # D re-enters this script to delete the highlighted generation, then refreshes the list
  let bind = ("D:execute(" + $self + " --delete {1} " + $profile
    + ")+reload(" + $self + " --list " + $profile + ")")

  let sel = (
    gen-rows $profile
    | ^fzf --height 40% --reverse --no-multi --delimiter "\t" --bind $bind
        --header $"($p.label) generations — enter: switch, D: delete, esc: quit \(* = current)"
    | complete
  )

  if $sel.exit_code != 0 or ($sel.stdout | str trim | is-empty) {
    return null
  }

  $sel.stdout | str trim | split row "\t" | get 0 | into int
}

def switch-hm [id: int, target: string] {
  let activate = ($target | path join "activate")
  if not ($activate | path exists) {
    error make --unspanned { msg: $"no activate script in ($target)" }
  }

  print $"activating home-manager generation ($id)"
  ^$activate
}

def switch-nixos [id: int] {
  # same two steps as nixos-rebuild --switch-generation: move the profile, then activate it
  print $"switching to NixOS generation ($id)"
  ^sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation $"($id)"
  ^sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
}

# Pick a home-manager or NixOS generation with fzf and switch to it.
def main [
  profile: string@"nu-complete profiles" = "hm"
  --list                  # print the fzf rows and exit, used by the reload binding
  --delete: int           # delete that generation and exit, used by the D binding
] {
  if $list {
    print (gen-rows $profile)
    return
  }

  if $delete != null {
    delete-gen $profile $delete
    return
  }

  let id = (pick-gen $profile)
  if $id == null { return }

  match $profile {
    "hm" => (switch-hm $id (list-gens (profile-info $profile) | where id == $id | first | get target))
    "nixos" => (switch-nixos $id)
  }
}
