{ pkgs, ... }:{ 
  programs.opencode = { 
    enable   = true;
    package  = pkgs.opencode;

    agents   = {};
    commands = {};
    skills   = {};
    themes   = {};
    tools    = {};
    rules    = "";
    settings = {};
    enableMcpIntegration = false;

    # settings = {   # config written to $XDG_CONFIG_HOME/opencode/config.json
    #   theme      = "opencode";
    #   model      = "anthropic/claude-sonnet-4-20250514";
    #   autoshare  = false;
    #   autoupdate = true;
    #   mcp        = true;
    # };

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
