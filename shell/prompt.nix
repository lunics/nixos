{ pkgs, lib, ... }:{

# todo
#docker
#nix-shell
#vagrant
# Direnv

programs.starship = {
  enable  = true;
  package = pkgs.starship;
  enableZshIntegration = true;
  settings = {
    add_newline     = true;
    scan_timeout    = 100;
    command_timeout = 1000;

    format = ''
      [╭](bold green)$directory$shell$sudo$git_branch$git_commit$git_metrics$git_state$package$shlvl$jobs$fill$status$cmd_duration
      [╰](bold green)$username@$hostname  '';

    fill.symbol = " ";

    username = {
      format            = "[$user]($style)";
      show_always       = true;
      disabled          = false; };

    hostname = {
      format            = "[$hostname](bold blue)[$ssh_symbol](bold magenta)";
      ssh_symbol        = "(ssh)";
      # trim_at         = ".local"; ?
      ssh_only          = false;
      disabled          = false; };

    directory = {
      format            = "[$path]($style)[$read_only]($read_only_style) ";
      read_only 	      = "🔒";
      read_only_style   = "red";
      truncation_length = 2;
      truncate_to_repo  = true;
      disabled          = false; };

    cmd_duration = {
      format            = "[$duration]($style)";
      style             = "bold yellow";
      min_time          = "2_000";
      show_milliseconds = true;
      disabled          = true; };

    git_branch = {
      format            = "[$branch(:$remote_branch)]($style) ";
      symbol            = "branch";
      style 	          = "bold purple";
      disabled          = false; };

    git_commit = {
      format              = "[\($hash$tag\)]($style) ";
      commit_hash_length  = 7;
      tag_symbol          = "";
      disabled          = false; };

    git_state = {
      format            = "\([$state( $progress_current/$progress_total)]($style)\) ";
      cherry_pick       = "[🍒 PICKING](bold red)";
      disabled          = false; };

    git_metrics = {
      added_style       = "bold blue";
      format            = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
      disabled          = true; };

    git_status = {
      format            = "([\[$all_status$ahead_behind\]]($style) ) ";
      ignore_submodules = false;
      disabled          = false; };

    container = {       # displays a symbol and container name inside a container
      format            = "[$symbol \[$name\]]($style) ";
      symbol            = "⬢";
      style             = "bold red dimmed";
      disabled          = false; };

    sudo = {
      format            = "[$symbol]($style) ";
      symbol            = "sudo";
      style             = "bold green";
      disabled          = false; };

    package = {         # shown when the current dir is a pkg repo
      format            = "[$symbol$version]($style) ";
      symbol            = "📦";
      version_format    = "v\${raw}";
      display_private   = true;
      disabled          = false; };

    character = {       # shows a character (usually an arrow) beside where the text is entered in your terminal.
      success_symbol    = "[->](bold green)";
      error_symbol      = "[x](bold red)";
      vimcmd_symbol     = "[vim](bold green)";
      disabled          = false; };

    status = {
      format            = "[$symbol$common_meaning$signal_name $status$maybe_int]($style) ";
      style             = "";          # bg:blue
      symbol            = "";          # ❌
      success_symbol    = "";          # 🟢
      not_executable_symbol = "";      # 🚫
      not_found_symbol  = "";          # 🔍
      sigint_symbol 	  = "";          # 🧱
      signal_symbol 	  = "";          # ⚡
      map_symbol        = true;
      disabled          = false; };

    shlvl = {
      format            = "[$shlvl]($style)";
      style 	          = "bold yellow";
      threshold         = 2;
      disabled          = false; };

    shell = {
      format            = "[$indicator](white) ";
      bash_indicator    = "bash";
      fish_indicator    = "fish";
      powershell_indicator = "psh";
      zsh_indicator     = "";       # don't show when zsh is the default
      disabled          = true; };

    jobs = {
      format            = "[$symbol$number]($style) ";
      style 	          = "bold blue";
      symbol            = "+";
      number_threshold  = 1;
      symbol_threshold  = 1;
      disabled          = false; };

    kubernetes = {
      symbol	          = "☸ ";
      format	          = "[$symbol$context( \($namespace\))]($style) in ";
      style	            = "cyan bold";
      detect_folders    = [];    # Which folders should trigger this modules
      detect_env_vars   = [];    # Which environmental variables should trigger this module
      disabled          = true; };

    helm = {
      format	          = "via [$symbol($version )]($style)";
      version_format	  = "v\${raw}";
      detect_extensions	= [];
      detect_folders	  = [];
      detect_files	    = [ "helmfile.yaml" "Chart.yaml" ];
      symbol	          = "⎈ ";
      style	            = "bold white";
      disabled          = false; };

    # go = {
    #   format	          = "via [$symbol($version )]($style)";
    #   version_format	  = "v\${raw}";
    #   symbol	          = "🐹 ";
    #   style	            = "bold cyan";
    #   detect_extensions	= ["go"];
    #   detect_files	    = ["go.mod" "go.sum" "go.work" "glide.yaml" "Gopkg.yml" "Gopkg.lock" ".go-version"];
    #   disabled          = true; };

    c.symbol = "C ";
    cmake.symbol = "cmake ";
    docker_context.symbol = "docker ";
    python.symbol = "py ";
    terraform.symbol = "terraform ";
  };
};

}
