{ config, pkgs, ... }:{ 
  programs.claude-code = {
    enable  = true;
    package = pkgs.claude-code;
    agents = {
      # code-reviewer = ''
      #   ---
      #   name: code-reviewer
      #   description: Specialized code review agent
      #   tools: Read, Edit, Grep
      #   ---

      #   You are a senior software engineer specializing in code reviews.
      #   Focus on code quality, security, and maintainability.
      # '';
      # documentation = ./agents/documentation.md;
    };
    agentsDir = null;     # path to a dir containing agent files
    commands = {
      # changelog = ''
      #   ---
      #   allowed-tools: Bash(git log:*), Bash(git diff:*)
      #   argument-hint: [version] [change-type] [message]
      #   description: Update CHANGELOG.md with new entry
      #   ---
      #   Parse the version, change type, and message from the input
      #   and update the CHANGELOG.md file accordingly.
      # '';
      # fix-issue = ./commands/fix-issue.md;
      # commit = ''
      #   ---
      #   allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
      #   description: Create a git commit with proper message
      #   ---
      #   ## Context

      #   - Current git status: !`git status`
      #   - Current git diff: !`git diff HEAD`
      #   - Recent commits: !`git log --oneline -5`

      #   ## Task

      #   Based on the changes above, create a single atomic git commit with a descriptive message.
      # '';
    };
    commandsDir = null;               # path to dir containing command files
    hooks = {
      #post-commit = ''
      #  #!/usr/bin/env bash
      #  echo "Committed with message: $1"
      #'';
      #pre-edit = ''
      #  #!/usr/bin/env bash
      #  echo "About to edit file: $1"
      #'';
    };
    hooksDir = null;    # path to dir containing hook files
    mcpServers = {
      # github = {
      #   type = "http";
      #   url = "https://api.githubcopilot.com/mcp/";
      # };
    };
    rules = {
      # code-style = ''
      #   # Code Style Guidelines

      #   - Use consistent formatting
      #   - Follow language conventions
      # '';
      # security = ./rules/security.md;
    };
    rulesDir = null;      # path to dir containing rule files
    skills = {
      # xlsx = ./skills/xlsx.md;
      # pdf-processing = ''
      #   Use pdfplumber to extract text from PDFs:
      # '';
    };
    skillsDir = null;
    memory = {
      # text = ""; # content for CLAUDE.md, mutually exclusive with memory.source
      #   # Project Memory
        
      #   ## Current Task
      #   Implementing enhanced claude-code module for home-manager.
        
      #   ## Key Files
      #   - claude-code.nix: Main module implementation
      # '';      
      # source = /path/claude-memory.md;
    };
    settings = {};
    enableMcpIntegration = false;
  };

  home = {
    packages = with pkgs; [ 
      claude-monitor        # real-time claude code usage monitor
      # claude-code-router  # to route claude code requests to different models and customize any request
      # claude-code-acp     # acp-compatible coding agent powered by the claude code sdk
      # open-interpreter    # KO build pygame
    ];

    sessionVariables."CLAUDE_CONFIG_DIR" = "${config._.share}/claude";
  };
}
