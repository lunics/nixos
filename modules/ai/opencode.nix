{ pkgs, ... }:{ 
  programs.opencode = { 
    enable   = true;
    package  = pkgs.opencode;

    agents   = {};
    commands = {};
    skills   = {};
    # tui      = {};
    tools    = {};
    rules    = "";
    settings = {};
    enableMcpIntegration = false;

    settings = {   # config written to $XDG_CONFIG_HOME/opencode/config.json
      theme      = "tokyonight";
      model      = "anthropic/claude-opus-4-6";
      # autoshare  = false;
      # autoupdate = false;
      # mcp        = false;
    };

    # See https://opencode.ai/docs/tools/
    # can be attribute set defining tools or a path to a directory containing multiple tool files
    # tools = {                 
    #   database-query = ''     # the attribute name becomes the tool filename
    #     import { tool } from "@opencode-ai/plugin"
    
    #     export default tool({
    #       description: "Query the project database",
    #       args: {
    #         query: tool.schema.string().describe("SQL query to execute"),
    #       },
    #       async execute(args) {
    #         // Your database logic here
    #         return `Executed query: ${args.query}`
    #       },
    #     })
    #   '';
    
    #   # Or reference an existing file
    #   api-client = ./tools/api-client.ts;
    # }
  };
}
